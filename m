Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9471358F
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 17:58:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2wIB-0007Zf-Qu; Sat, 27 May 2023 11:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q2wI9-0007ZG-BY; Sat, 27 May 2023 11:57:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q2wI7-0001SU-Iu; Sat, 27 May 2023 11:57:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 92C998D1A;
 Sat, 27 May 2023 18:57:09 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7103C7D1F;
 Sat, 27 May 2023 18:57:08 +0300 (MSK)
Message-ID: <39719712-9058-aac2-247c-8dfb2c2622c7@tls.msk.ru>
Date: Sat, 27 May 2023 18:57:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 04/12] configure: unset harmful environment variables
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org
References: <20230526160824.655279-1-pbonzini@redhat.com>
 <20230526160824.655279-5-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230526160824.655279-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

26.05.2023 19:08, Paolo Bonzini wrote:
..
>   # Unset some variables known to interfere with behavior of common tools,
> -# just as autoconf does.
> -CLICOLOR_FORCE= GREP_OPTIONS=
> -unset CLICOLOR_FORCE GREP_OPTIONS
> +# just as autoconf does.  Unlike autoconf, we assume that unset exists.
> +unset CLICOLOR_FORCE GREP_OPTIONS BASH_ENV ENV MAIL MAILPATH CDPATH

Wonder how relevant all this is.

gnu grep (from coreutils) does not document and does not use $GREP_OPTIONS.

While $BASH_ENV is relevant for non-interactive mode (ie, when running as
a script), but this variable a) is not used when it is invoked as sh (as
opposed to bash), and b) it is a way to pass actual additional configuration
to the shell, -- we do not override $PATH, do we? So why we override $BASH_ENV?
For example, with $BASH_ENV, one can turn on tracing of shell functions, which
is nearly impossible now when everything is run from within meson.
Ditto for $ENV.

Others - MAIL and MAILPATH? - those are only relevant for interactive usage,
and only when mail actually goes to /var/mail/$user (or equivalent), it does
not matter for scripts at all.

CLICOLOR_FORCE is interesting, and it was there before already.  It looks like
whomever set that, don't really care about things like ./configure failing due
to grep et al trying to color-paint its output.  This variable shouldn't be used
normally, it smells like a single-use thing - eg, to force color when output is
displayed within less(1), or when grepping output but keeping colors.  If it
is set in environment before ./configure is run, it's not our fault.

Now we come to CDPATH. But even there, it should not contain something else besides
"." (current dir) as the first element, it's kinda interesting when CDPATH has
something else in there.  We've been here for like decades, and this is the
first time we've hit this.

Do we _really_ need to reset all this? Especially the $ENV and $BASH_ENV thing,
which are useful..

But oh well :)

/mjt

