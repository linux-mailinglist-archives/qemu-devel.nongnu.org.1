Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7743B79D14F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:44:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2kb-0002k2-Kp; Tue, 12 Sep 2023 08:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qg2kZ-0002iq-DX
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qg2kW-0000Cw-V1
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694522651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zzX7H26uoPk/GDawUkWPVkLMOckdSwmAqhD7RWlwrU=;
 b=QSoohr9zSAe29nJdzwnKz8FFpd6HSDuTGrubahu2TVn2fIgpcwI4Z5753aZz4XfSCPZh5+
 NoEfgnAikOS1wlpStcrFod8f3kbF9uKS0OlorA7ghSS9V9k3JhdugAdKEZL1KQLuOPR5hM
 zUh9EnPf8Y/SiSoCnvgQYB8to9M3Bz4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-KrbBRCeqO3KlluETafXdQw-1; Tue, 12 Sep 2023 08:44:08 -0400
X-MC-Unique: KrbBRCeqO3KlluETafXdQw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a355c9028so366444566b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 05:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694522647; x=1695127447;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3zzX7H26uoPk/GDawUkWPVkLMOckdSwmAqhD7RWlwrU=;
 b=Eaf8/F7ahXaM0wnc69Z0L3la6+ows+bDp7Mt2GAOW1qCn5jT2fINCJ0TBbDt+r4c2H
 5F18MLDwmKLon133iWFauSrMxlWOZmMcSomYpG/kcTWdQetrLbF7ituPT7ChUkdysb2U
 D192Hdkgj9QbmBNERg96Kons08XTh0qnUcKDyWnebPbcUywiUU2HNMmuP77hPgOycIu/
 biAZhfL8xNfXdvTuSqndwOUiAExGmWuHyLRxEY3+C563oDQXegPSJhRLnXKXa7RbsPzX
 bpAgdH/jC9e4dmfm18KiriFwjRbT6K9p0ybZ8n/2AhJZ7sE5XmQIPr9h5UIoLd2Mhow3
 v/PQ==
X-Gm-Message-State: AOJu0YxooPJj0BXU5N6rI/BpasqH5lVG8n8aGX1vl5Yko0Jn9kvZbnyj
 +JxpGu2IuaBx5lbvK6Ui8P4bzKG/PnTopO48eaNiVZAonfBok1xPUDi23k2wgwrOfYmdWnUUUk9
 fjpsKw1RUyNzEOuw=
X-Received: by 2002:a17:907:6087:b0:9a9:e53d:5d5b with SMTP id
 ht7-20020a170907608700b009a9e53d5d5bmr9973722ejc.41.1694522647332; 
 Tue, 12 Sep 2023 05:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGegB6q7SOkEbWEsVZLk33Xl2xS6GyRKkzSsBrxCRGAt95wVch4luLEaEOwwCqINYjM9ODj2Q==
X-Received: by 2002:a17:907:6087:b0:9a9:e53d:5d5b with SMTP id
 ht7-20020a170907608700b009a9e53d5d5bmr9973711ejc.41.1694522646985; 
 Tue, 12 Sep 2023 05:44:06 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 bu20-20020a170906a15400b00997d7aa59fasm6911911ejb.14.2023.09.12.05.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 05:44:06 -0700 (PDT)
Message-ID: <c6d412e5-d8b2-145e-5c3e-ce8f1dfa8595@redhat.com>
Date: Tue, 12 Sep 2023 14:44:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/14] Block patches
From: Hanna Czenczek <hreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20230901081804.31377-1-hreitz@redhat.com>
 <CAJSP0QV4-dR2-2r+4E0N+yWHdzNF0A+FkHGU7Q3uiEg3wxR5Fg@mail.gmail.com>
 <4dfb202f-5bd5-57f9-0aeb-6121b0697a6c@redhat.com>
Content-Language: en-US
In-Reply-To: <4dfb202f-5bd5-57f9-0aeb-6121b0697a6c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07.09.23 13:21, Hanna Czenczek wrote:
> On 06.09.23 15:18, Stefan Hajnoczi wrote:
>> On Fri, 1 Sept 2023 at 04:18, Hanna Czenczek <hreitz@redhat.com> wrote:
>>> The following changes since commit 
>>> f5fe7c17ac4e309e47e78f0f9761aebc8d2f2c81:
>>>
>>>    Merge tag 'pull-tcg-20230823-2' of 
>>> https://gitlab.com/rth7680/qemu into staging (2023-08-28 16:07:04 
>>> -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/hreitz/qemu.git tags/pull-block-2023-09-01
>> Hi Hanna,
>> Please push a signed tag (git tag -s). Thanks!

By the way, I meant to imply that I’m not going to push a new tag at 
this time.

I have generated this pull request as I always do, using a script that 
automatically signs the tag.  gpg asked me to enter my key password, 
indicating something had been signed, and the methods I know of tell me 
that the tag is indeed signed.  So as far as I can tell, the tag is 
signed as usual.  If I were to create a new pull request, I would do it 
the exact same way, which I expect would yield the same result, so we’d 
have the same problem again.

To get a different result, I need to know how you determine the tag not 
to be signed, so I can reproduce it and potentially fix the problem in 
my workflow.

Hanna

> Is it not signed?  I don’t think gitlab has support to show that, but 
> github shows it as verified: 
> https://github.com/XanClic/qemu/releases/tag/pull-block-2023-09-01
>
> And when I clone it:
> ```
> $ git clone https://gitlab.com/hreitz/qemu -b pull-block-2023-09-01 
> --depth=1
> [...]
> $ cd qemu
> $ git tag -v pull-block-2023-09-01
> LANG=C git tag -v pull-block-2023-09-01
> object 380448464dd89291cf7fd7434be6c225482a334d
> type commit
> tag pull-block-2023-09-01
> tagger Hanna Reitz <hreitz@redhat.com> 1693555853 +0200
>
> Block patches
>
> - Fix for file-posix's zoning code crashing on I/O errors
> - Throttling refactoring
> gpg: Signature made Fri Sep  1 10:11:46 2023 CEST
> gpg:                using RSA key 
> CB62D7A0EE3829E45F004D34A1FA40D098019CDF
> gpg:                issuer "hreitz@redhat.com"
> gpg: Good signature from "Hanna Reitz <hreitz@redhat.com>" [ultimate]
> Primary key fingerprint: CB62 D7A0 EE38 29E4 5F00  4D34 A1FA 40D0 9801 
> 9CDF
> ```
>
> Hanna


