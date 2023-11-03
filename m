Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3277E001F
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 10:55:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyqtq-00081S-4D; Fri, 03 Nov 2023 05:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qyqtW-0007su-Kh
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:55:19 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qyqtU-0004wc-K5
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 05:55:14 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-27ff7fe7fbcso1703687a91.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1699005311; x=1699610111;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IXFNir4/M9QIA7yF8Yfbd7hUHCm+tdqkUFtCJb3xW04=;
 b=WufnW4X8NbNdqsm5BC2SFE6zWnlSwldWqY7OqAC2Kkg4TplGSSV9Wh+lIIF2h95DAA
 ymdiB57IX4eW7wQrjCEMZO6MMhIH3rQUm7QtGWZFX8XgM8trf1faaV2F465f+ZPUswqx
 6sHKhqYlRHmoJo82f6GuKYhs1jjVaIA7HPJPBnn+zF7Pl/ncAqTWlTPnwlzhc7geVdHa
 xU0g/qqZNqcPsySBMv8QII/1uGBuUAYFHLNbo3Vz8y5+o2lBa1ffVbOlLZP96ph798QK
 VhiDzn+wu3ZwmxXF15mw9Xf2FaxHgtoPL/mRGUNtSNLk2yGRa7vFxnWNKnXDXEEc7CBE
 rkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699005311; x=1699610111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IXFNir4/M9QIA7yF8Yfbd7hUHCm+tdqkUFtCJb3xW04=;
 b=uHUjMkLyt5T9t1iMGmqgSljwh/Vzp76FqQ+muYAnb0W7GNo7RzZ5iHApua+wgi6MQI
 Mw6MD8xL50xj9/dH/PmHp0MG/3dGKT92usEvjhh2hE876ZZl9JGYMlovLzEydfyzv4n7
 cXfFh1Nih9NvZ5AW4P1gkW+JoPGrriW7uQd110Xt8CoTI7i1nv865B/Zo0nTkyZRKOan
 6pgcUZnp720NLRPTMxrYe1dGyFYxkh5YXCq+5yxlVBmt0luAb7L141RuVqmahzZb/R47
 PEO6ObVRuL6wSkNF3ySMtlaxE3bPOAPkMFOotgawPTSoAG/yOI54464wTEI6oF3b6Bvu
 pfeA==
X-Gm-Message-State: AOJu0YxvzKEteQBowEkb84EuADtTI1tpeUmEiBk3UbcPEO1heW8md2No
 5j7zOJv+7rvwiyA/7yz972flag==
X-Google-Smtp-Source: AGHT+IEo/fva+lSP+W7ggUsb9noQnysFx4SWiYVavoW/fsr3kg7egrPbn5HksngxMmLCgNPcv8mAcA==
X-Received: by 2002:a17:90a:9284:b0:280:2406:7021 with SMTP id
 n4-20020a17090a928400b0028024067021mr15155505pjo.35.1699005310935; 
 Fri, 03 Nov 2023 02:55:10 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 mf4-20020a17090b184400b00280215e7aebsm1030623pjb.15.2023.11.03.02.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 02:55:10 -0700 (PDT)
Message-ID: <dbd1d662-bf90-4982-b316-281923a0d778@daynix.com>
Date: Fri, 3 Nov 2023 18:55:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
 <20231102053202-mutt-send-email-mst@kernel.org>
 <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
 <2fbdee21-60f4-49ff-b61b-923c895f90ba@daynix.com>
 <CAOEp5Oc+wGmxTAezMz4f03kuqsngHAcpi7pqPQDT=PWuy=L7BA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Oc+wGmxTAezMz4f03kuqsngHAcpi7pqPQDT=PWuy=L7BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/03 18:35, Yuri Benditovich wrote:
> 
> 
> On Thu, Nov 2, 2023 at 4:56 PM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2023/11/02 19:20, Yuri Benditovich wrote:
>      >
>      >
>      > On Thu, Nov 2, 2023 at 11:33 AM Michael S. Tsirkin
>     <mst@redhat.com <mailto:mst@redhat.com>
>      > <mailto:mst@redhat.com <mailto:mst@redhat.com>>> wrote:
>      >
>      >     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich wrote:
>      >      > Probably we mix two different patches in this discussion.
>      >      > Focusing on the patch in the e-mail header:
>      >      >
>      >      > IMO it is not acceptable to fail QEMU run for one feature
>     that we
>      >     can't make
>      >      > active when we silently drop all other features in such a
>     case.
>      >
>      >     If the feature is off by default then it seems more reasonable
>      >     and silent masking can be seen as a bug.
>      >     Most virtio features are on by default this is why it's
>      >     reasonable to mask them.
>      >
>      >
>      > If we are talking about RSS: setting it initially off is the
>     development
>      > time decision.
>      > When it will be completely stable there is no reason to keep it
>     off by
>      > default, so this is more a question of time and of a readiness of
>     libvirt.
> 
>     It is not ok to make "on" the default; that will enable RSS even when
>     eBPF steering support is not present and can result in performance
>     degradation.
> 
> 
> Exactly as it is today - with vhost=on the host does not suggest RSS 
> without  eBPF.
> I do not understand what you call "performance degradation", can you 
> describe the scenario?

I was not clear, but I was talking about the case of vhost=off or peers 
other than tap (e.g., user). rss=on employs in-qemu RSS, which incurs 
overheads for such configurations.

