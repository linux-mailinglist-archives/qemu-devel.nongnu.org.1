Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E9A7ED342
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:47:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3MlP-00015W-LI; Wed, 15 Nov 2023 15:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r3MlL-000156-Ak; Wed, 15 Nov 2023 15:45:27 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r3MlG-0002vA-Df; Wed, 15 Nov 2023 15:45:27 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-66d093265dfso423606d6.3; 
 Wed, 15 Nov 2023 12:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700081119; x=1700685919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bY+5CSehvVBGtwgNuboXUV3/1/gJ/dZP7ytCrDrqtfQ=;
 b=MMnmnNIBP96BeJTjSc3UEi0EVVX59lS7e55MrHWcR/PnGaBPQKuCRNClcU0U78wPk8
 qeudxdiwN6Y1gHDfMozPhM5tQj7IG8392EyWGncAtvy1vdT/M6GCCNPbS+0IEFLHABfK
 CTivlRUw2j0z0PWiVHSoAloGyVKd3l0+WQDm7fv15Imnz/uZUNUC15jcbA2p5pZTMdOt
 5/ae8kOAr0H8TYkYIOXFAZq99hsLWLT8lirVp6oJGc48RH3aBVtrB3j6+0iD7jxgSK36
 h5kQINIRa+bDqg28nxBplmcux78gvTOg0+0bKToNd6IoiSXR1Aio3Uo7yticwcp7eJt0
 fpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081119; x=1700685919;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bY+5CSehvVBGtwgNuboXUV3/1/gJ/dZP7ytCrDrqtfQ=;
 b=t+a1pAT8JQezy6H3rGU70D6CvyLKyK1ZbRMqMsaKyoCfyQRrU18cUdbrwzc+zNmbtj
 HqI2O0VRtUlbhesjG8anJbPnsIi3wv9Fy9Tw1/B7RQ1ewJsViD82H+F9+ENz+C2wwNce
 W0dwKhxkrx56VglwSYNEx+1hSspohQ9QyzV6JTh6p2LaTv14Vd7dlDD4AqI4SktqNp4v
 ngJHs+2ntKU6qY5gtp0CTwQSAgK1lcCeKwn4VbcY/HHHdUab60EN0OpP79AS0YzbeVGq
 JtXw+BJj4i8FnrX7nu8FNTTGEwdVehm+hg9/gGkkdfNJX8rk81TN3Qz8cb3fFBxPTKAW
 52zg==
X-Gm-Message-State: AOJu0YxQ0M/xzoImarl5wbHs3jCOL13lJFbyj64cAkGXQ9dA7hPolGzq
 rEsfkdva+vzn3uM8UoijWNM=
X-Google-Smtp-Source: AGHT+IFgPcfE9Xh25SpD1WU5BPRKZgmYrNpCNYZXXrb4uiJ+zbf5znm3WLPnO37uQtF4D2nqSDLRFw==
X-Received: by 2002:a05:6214:1306:b0:66f:ba6e:73e8 with SMTP id
 pn6-20020a056214130600b0066fba6e73e8mr9414369qvb.41.1700081119356; 
 Wed, 15 Nov 2023 12:45:19 -0800 (PST)
Received: from [172.20.0.103] ([12.191.197.195])
 by smtp.gmail.com with ESMTPSA id
 ki10-20020a05622a770a00b00418189b689csm3459337qtb.10.2023.11.15.12.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 12:45:18 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <1388a0c0-cfc2-4957-9bce-08499e9ac84d@xen.org>
Date: Wed, 15 Nov 2023 15:45:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/xen: clean up xen_block_find_free_vdev() to avoid
 Coverity false positive
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
References: <20231115172723.1161679-1-dwmw2@infradead.org>
 <20231115172723.1161679-4-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20231115172723.1161679-4-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=xadimgnik@gmail.com; helo=mail-qv1-xf31.google.com
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 15/11/2023 12:24, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Coverity couldn't see that nr_existing was always going to be zero when
> qemu_xen_xs_directory() returned NULL in the ENOENT case (CID 1523906).
> 
> Perhaps more to the point, neither could Peter at first glance. Improve
> the code to hopefully make it clearer to Coverity and human reviewers
> alike.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/block/xen-block.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


