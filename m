Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A607156E9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 09:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3tuZ-00079x-4r; Tue, 30 May 2023 03:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q3tuM-00079K-QO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:36:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q3tuK-0001EW-Po
 for qemu-devel@nongnu.org; Tue, 30 May 2023 03:36:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 51F33945B;
 Tue, 30 May 2023 10:36:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C47EB8566;
 Tue, 30 May 2023 10:36:36 +0300 (MSK)
Message-ID: <e10a91a7-a3e3-79d0-f413-4e5a6f8f325b@tls.msk.ru>
Date: Tue, 30 May 2023 10:36:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] gitlab: improvements to handling of stable staging
 branches
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230526101934.935969-1-berrange@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230526101934.935969-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

26.05.2023 13:19, Daniel P. Berrangé wrote:
> We just (re)discovered that our gitlab rules don't work nicely with
> pipelines running from stable staging branches. Every pipeline gets
> published with the 'latest' tag, whether its the main staging branch
> or one of the stable staging branches. If pipelines for multiple
> staging branches run concurrently they'll get very confused and end
> up using the wrong container content. eg a 8.0 stable job will get
> run with a container from the development branch, or vica-verca.
> 
> With this series we dynamically change the tag so that the 'staging'
> branch still uses 'latest', but the stable 'staging-X.Y' branaches
> use a 'staging-X-Y' container tag.
> 
> We also let the container tag be set explicitly via the new variable
> 
>    QEMU_CI_CONTAINER_TAG
> 
> to facilitate CI testing, the new variable
> 
>    QEMU_CI_UPSTREAM
> 
> can be set to the fork namespace, to allow contributors to run a
> pipeline as if their fork were upstream.

Daniel, can you describe in a bit more detail (or refer to some text
to read) about how this whole thing works, aka the "big picture"?

It smells like we're doing huge wasteful job here, but it might be
just because I don't understand how it works.

Can't we prepare all containers separately and independently of regular
qemu commits, and just use the prepared container images every time
we run tests?

Also, why can't several tests (from several different pipelines, maybe
run for different branches) use the same images (if we don't re-prepare
them on each and every test run)?

I understand different branches might have different requirements for
containers, like using older version of some OS, etc, - this is done
by naming the container images appropriately, like debian-latest (for
master) vs debian-bullseye (for stable-7.2) etc.

Still, preparing container images might be done separately from regular
commits, like when ci config changes or when new version of something
(fedora/redhat/etc) is released.

How does it all works, why we need to couple container creation to
regular commits and re-create containers on every test run?

Thank you!

/mjt

