Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0183713B79
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 20:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Krn-0004gB-Ut; Sun, 28 May 2023 14:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3Krm-0004fs-CC
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3Krk-00053M-6q
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685297498;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=t/JUGZWaCNVZWiZvMLqtUxcIRZnI4GZiJ5KkiafFbyE=;
 b=cWka8pCDxGWf2jDrQTWR7Uus6E/1VG36iO1HxTCXOZOkCwmT/OIUENNU4u/8c9vWJNeMQC
 sWmiRM9THXPSZHhWEMUiFj1H7wJ3U+t1DhId2W+MBq417BNRNXl0MytcXT9Qs/cKl+uPHX
 tVZZTFWT7XcuYI3/TF4R2Vf0U4aCY8o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-hyFiUXW0MAaQ-bWaKHdqTw-1; Sun, 28 May 2023 14:11:36 -0400
X-MC-Unique: hyFiUXW0MAaQ-bWaKHdqTw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f608ea689cso16545305e9.3
 for <qemu-devel@nongnu.org>; Sun, 28 May 2023 11:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685297495; x=1687889495;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/JUGZWaCNVZWiZvMLqtUxcIRZnI4GZiJ5KkiafFbyE=;
 b=KJJ1D8qLeInInX9BSuRQVSkHEnb7CBaiqAlPDQCqfFYX0+c6v/Z9tGXMAe0y1ZhexD
 VsDfD3sQvbn5DgO5AvWkmqCGnoxlVEw5ze4Eg4vNtMOYX2y9qb8Ic8cqVmWAcBMitPGd
 zs/rPKqVfpixvXp5dv2y12VTY+sgfJ/ulP98Cl8gmOJN6vRn+h9XqTk+Qn2MOvQf7yVu
 IRn+Bam9Q5N6NccBmgi2dhCFxZJdTmpq9d/Tb6bZBA+iO4crpo/XxhDXQ6s0dwPPAhGJ
 UnFsgc6bUkhoehRHGQzxEZlammHcR3T/mgrqXUov8+RbdzwWkaPoYVA+3wljSMkAvAKI
 mW4g==
X-Gm-Message-State: AC+VfDwkfRqFBJ6s9L4/+nwfXIcy18amA6qQ0My9QiN8Z7jOay3Gp08M
 dNRTxX+v8ddRXySBiDzC9/ziWVpNO0zpM7vf1M+6mWB+xEt/DnI+Zu24vv2EVM3l3ejKbT5D/9f
 GUQJrBdQ8rIYG1YA=
X-Received: by 2002:a05:600c:2904:b0:3f4:2737:a016 with SMTP id
 i4-20020a05600c290400b003f42737a016mr7560949wmd.29.1685297495458; 
 Sun, 28 May 2023 11:11:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oRe3huPpeIgsGjvhu1Pmn7EQu52ufyxSEFhbIQz8ta3sDMSY+513TnsG8FzmxwLziXZwHsA==
X-Received: by 2002:a05:600c:2904:b0:3f4:2737:a016 with SMTP id
 i4-20020a05600c290400b003f42737a016mr7560941wmd.29.1685297495201; 
 Sun, 28 May 2023 11:11:35 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f8-20020a1c6a08000000b003f41bb52834sm15507847wmc.38.2023.05.28.11.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 11:11:34 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PULL 04/12] configure: unset harmful environment variables
In-Reply-To: <39719712-9058-aac2-247c-8dfb2c2622c7@tls.msk.ru> (Michael
 Tokarev's message of "Sat, 27 May 2023 18:57:08 +0300")
References: <20230526160824.655279-1-pbonzini@redhat.com>
 <20230526160824.655279-5-pbonzini@redhat.com>
 <39719712-9058-aac2-247c-8dfb2c2622c7@tls.msk.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Sun, 28 May 2023 20:11:33 +0200
Message-ID: <87h6rw1g2y.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Michael Tokarev <mjt@tls.msk.ru> wrote:
> 26.05.2023 19:08, Paolo Bonzini wrote:
> ..
>>   # Unset some variables known to interfere with behavior of common tools,
>> -# just as autoconf does.
>> -CLICOLOR_FORCE= GREP_OPTIONS=
>> -unset CLICOLOR_FORCE GREP_OPTIONS
>> +# just as autoconf does.  Unlike autoconf, we assume that unset exists.
>> +unset CLICOLOR_FORCE GREP_OPTIONS BASH_ENV ENV MAIL MAILPATH CDPATH
>
> Wonder how relevant all this is.
>
> gnu grep (from coreutils) does not document and does not use $GREP_OPTIONS.
>
> While $BASH_ENV is relevant for non-interactive mode (ie, when running as
> a script), but this variable a) is not used when it is invoked as sh (as
> opposed to bash), and b) it is a way to pass actual additional configuration
> to the shell, -- we do not override $PATH, do we? So why we override $BASH_ENV?
> For example, with $BASH_ENV, one can turn on tracing of shell functions, which
> is nearly impossible now when everything is run from within meson.
> Ditto for $ENV.
>
> Others - MAIL and MAILPATH? - those are only relevant for interactive usage,
> and only when mail actually goes to /var/mail/$user (or equivalent), it does
> not matter for scripts at all.
>
> CLICOLOR_FORCE is interesting, and it was there before already.  It looks like
> whomever set that, don't really care about things like ./configure failing due
> to grep et al trying to color-paint its output.  This variable shouldn't be used
> normally, it smells like a single-use thing - eg, to force color when output is
> displayed within less(1), or when grepping output but keeping colors.  If it
> is set in environment before ./configure is run, it's not our fault.
>
> Now we come to CDPATH. But even there, it should not contain something else besides
> "." (current dir) as the first element, it's kinda interesting when CDPATH has
> something else in there.  We've been here for like decades, and this is the
> first time we've hit this.
>
> Do we _really_ need to reset all this? Especially the $ENV and $BASH_ENV thing,
> which are useful..

CDPATH -> It broke my setup, I have had this on my .bashrc since the
90's:

export CDPATH=.:~/work:/scratch/

For the rest, I don't know.  But if autoconf disables them, some weird
system, somewhere in the world makes this fail.

Later, Juan.


