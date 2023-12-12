Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C1380E369
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 05:41:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCuZn-0005IV-6p; Mon, 11 Dec 2023 23:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rCuZl-0005Hv-P7; Mon, 11 Dec 2023 23:40:57 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1rCuZk-00011y-4r; Mon, 11 Dec 2023 23:40:57 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ce72730548so4515237b3a.1; 
 Mon, 11 Dec 2023 20:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702356054; x=1702960854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ukeq30dZk5R9bWQpYKDnSfpdPGljlsWC2/i6+A/VGcc=;
 b=Uz2MTgBHMGCzrqPw2y7fElLSEIoP6YECCamTDoD3hA/roeatjpaLuZ4yWsQB9Vqtu6
 UWfjaf9T4ac1XEfFxFyPFsuOZ9OiTKqxPtV3yoDkf4Y+jukjNzTAopDOTSMCnwmdChYi
 OCg/ZRbDX7iti08AS5ObmpQZAwST1p0z9ljWK+mdzKmAQFns8UTXgJiuDmJg5fqIH14r
 iQ8wnoR+RTg1kxkwsVOqUIq0lJ9Ol3Tug13cLOuXEziMBwx3Pn65YkrquK/Aw6c1mpMb
 eNW11EbZMB+UbJ5IxkPDEXEt2X3yf6ewopgwduGVXiC4lT8fJqYQjoILJJa86tWCgZ/2
 oNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702356054; x=1702960854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ukeq30dZk5R9bWQpYKDnSfpdPGljlsWC2/i6+A/VGcc=;
 b=vDfcnCl0xs+UGFOlZapZyroe1lHptPobf3Fq6Wdl/xUxCKe5XhpWVY5pf5FsflJMfR
 bBocUuGPZTyauz9YOQQrbAYaFDHztwvEhwS3PHcTcuo8P09aGPmEK1qpT0sr6BHRhCBM
 gTWuBPeXJwShVAMwzl5dl8wdYFrg1sBHyX/WyBdowadQmAl70Jh4e2AkzGmYSssExzC+
 Q7BHQaKEghQLDbBhDJh8Fyb7dNorzOVwpnQrwsZDMkF56D0jfjm4fYJyAB9UVynryyay
 k7Xto/SoHT9HrAx2WB26+jp3/9OXL5NKohznxJvpjlb6QeJ6oHyM+PveuEkAHk33FVGf
 q5fA==
X-Gm-Message-State: AOJu0YwjxfTuojKkd6FdAg/yI/FatyW0xCqpsPEPxEhlDs9nFV67hN3c
 XIHp8EwD7paP7fIePDSGVOY=
X-Google-Smtp-Source: AGHT+IHOvqATa7YgutVlKgn1hwtt5lHWQ9HsCTLb9m9GlsI9ccLrR1guvc2BjfQgZlvxnMOBwv1Itg==
X-Received: by 2002:a05:6a00:1307:b0:6ce:2731:e86b with SMTP id
 j7-20020a056a00130700b006ce2731e86bmr6762502pfu.50.1702356054335; 
 Mon, 11 Dec 2023 20:40:54 -0800 (PST)
Received: from [192.168.0.22] ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a656854000000b005b7dd356f75sm6206291pgt.32.2023.12.11.20.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 20:40:53 -0800 (PST)
Message-ID: <806e361d-e51b-498f-937e-b472191db59e@gmail.com>
Date: Tue, 12 Dec 2023 13:40:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Support for Zoned UFS
Content-Language: ko
To: daejun7.park@samsung.com, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "thuth@redhat.com" <thuth@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Seokhwan Kim <sukka.kim@samsung.com>,
 Yonggil Song <yonggil.song@samsung.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 JinHwan Park <jh.i.park@samsung.com>
References: <CGME20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
 <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

I've already done all the ufs related review.


If the SCSI maintainers approve this patchset, I'll put it in my tree 
and create a pull request.


Thank you,

Jeuk


On 12/8/2023 3:09 PM, Daejun Park wrote:
> This patch enables zoned support for UFS devices.
> By applying this patch, a QEMU run can use parameters to configure whether
> each LU of each UFS is zoned, and the capacity, size, and max open zones.
> Zoned UFS is implemented by referencing ZBC2.
> (https://www.t10.org/members/w_zbc2.htm)
>
> Daejun Park (3):
>    hw/ufs: Support for Zoned UFS
>    hw/scsi: add mode sense support for zbc device
>    tests/qtest: Add tests for Zoned UFS
>
>   hw/scsi/scsi-disk.c    |  13 +-
>   hw/ufs/lu.c            | 616 +++++++++++++++++++++++++++++++++++++++++
>   hw/ufs/ufs.c           |   6 +-
>   hw/ufs/ufs.h           |  32 +++
>   include/block/ufs.h    |  31 +++
>   tests/qtest/ufs-test.c | 178 ++++++++++++
>   6 files changed, 870 insertions(+), 6 deletions(-)
>

