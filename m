Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528C7EF474
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 15:29:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zpi-0002EO-6R; Fri, 17 Nov 2023 09:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3zpg-0002BB-Dk
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:28:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r3zpe-0002fA-TM
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 09:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700231309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sHMlJdBFoffQ2r3k6YTsHvt+ZpAI+OTWgPsykiVJ56I=;
 b=FRZktTq1aWDuegsiQaFz535nmrxtx9F8jWIfVHUM8CpUfTmQzu3D7BXnOcbWIKLobWqBU5
 6NMgsdTVAYsN0sSrbXnvPalZeDu+nCG/kTqgF9UDK5twju3rl11C5cI8JviNKAUTO36VGv
 8kl5CoYEKVx/Pz/7g7Hsr38C2jxooHQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-fLDI6tu7PAuRwRs4xi92pw-1; Fri, 17 Nov 2023 09:28:26 -0500
X-MC-Unique: fLDI6tu7PAuRwRs4xi92pw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7788fb069abso534925885a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 06:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700231306; x=1700836106;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sHMlJdBFoffQ2r3k6YTsHvt+ZpAI+OTWgPsykiVJ56I=;
 b=bV/t0zrknfjwW0H88P6ueh4CioWJ+qisd8s7/xxWFdDBz3dIKn3ZODHbdBUqA6YpzM
 6461zr0yIO4ksAG/X//0uEPA636sCCLhRIUfy7bAm/KLd2RHDpwd+iXWUUuDjkUpwExM
 Y/W+N7yvdZsikMhDiVq6pjJ0d23ksFeCBr13SpeJKfOHvmwl2g7795TBbLM4R9DsvIlg
 PCserWfgcfrHOYizSuFMXr2ATRpD3eCjx/heGPbXPGkMzzB8FfQOUo38UxDpevaY5iJw
 B2aPgNak6zRYwuDMZJql5yCzIh1ciG6j5d3pCIaYluzLp+omTc8ScKYsrh1TecYTv89F
 /wZw==
X-Gm-Message-State: AOJu0Yx5Wq4VozSNgPTbri0Wwh4DgOrRAQrB1Tg49Cjbn7kq9reyNrPA
 OXXOULbWuCIdFWYYjr6GlQwi8kc60K1gupK9som0PgEHkdYqx6GG8UH1C2NOdO5OV1BzxJxH7KT
 6NGYPlqA3ASlBMPk=
X-Received: by 2002:a05:620a:4688:b0:774:267d:4252 with SMTP id
 bq8-20020a05620a468800b00774267d4252mr7666817qkb.15.1700231305924; 
 Fri, 17 Nov 2023 06:28:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmKicBbQvhgXFV2bbQ7T4TO4l+zmd4Ri1NmqJwfgh+rQA6fgFRddNuNxrkYioC313lWUy3dQ==
X-Received: by 2002:a05:620a:4688:b0:774:267d:4252 with SMTP id
 bq8-20020a05620a468800b00774267d4252mr7666789qkb.15.1700231305680; 
 Fri, 17 Nov 2023 06:28:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a056214028a00b00655ec7bbfd0sm666842qvv.7.2023.11.17.06.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 06:28:25 -0800 (PST)
Message-ID: <e159fae5-ad82-4dce-bef1-264f81b5bb49@redhat.com>
Date: Fri, 17 Nov 2023 15:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: Add VFIO iommufd backend documentation
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231117093512.1999666-1-zhenzhong.duan@intel.com>
 <9e2a138d-48b1-47d1-88f5-2794c3692854@redhat.com>
In-Reply-To: <9e2a138d-48b1-47d1-88f5-2794c3692854@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/17/23 13:58, Cédric Le Goater wrote:
> On 11/17/23 10:35, Zhenzhong Duan wrote:
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> The content looks good but it lacks formatting. Please try to generate
> the docs.

Please check my vfio-8.2 branch.

Thanks,

C.


