Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DB9B1BB3E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Aug 2025 22:02:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujNqU-0006Eq-23; Tue, 05 Aug 2025 16:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujNqR-0006Cc-B2
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ujNqO-0003UM-7a
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 16:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754424063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zShoLhc7QdLofb7EBM16GdCEn/h1ODh8peITA4SPWeA=;
 b=Y0+F2KsKHlEMFLbWCPJq7HrNyyfcYoGE8fAChvFFBBy1Zpdnlk8eqYE7mn6sLKuaaNDc+/
 hgtABYwHMJJFdrtXc/F3XhOTZmsdak/tfTqV9/H+rFxCqLahvo0Y84GIWMZMNZssMh3ZU/
 TTM6bh4W01v/LhHDgjw7HI4zc8djfOs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-QMGAwLRSMsWvJFEc10eoTA-1; Tue, 05 Aug 2025 16:01:02 -0400
X-MC-Unique: QMGAwLRSMsWvJFEc10eoTA-1
X-Mimecast-MFC-AGG-ID: QMGAwLRSMsWvJFEc10eoTA_1754424061
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e696444d0cso735887585a.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 13:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754424061; x=1755028861;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zShoLhc7QdLofb7EBM16GdCEn/h1ODh8peITA4SPWeA=;
 b=RCF4sSF5i3GblqfD0voM1jMe8eGxhUKg3i8RDtwl21xbWTsnZ/ormlkXK4S2Sw/z+P
 4YizqMJJ/rGMeXVIeHGOihLBFV/nPqMUA5gld2h1jSO0LfxcQ0GJNkpUioRJ5+3qt7zi
 2rc19Lgvev4Q84Hi4cId4L/V3aGphySU1i3lvLF6ojSMcuOgG/Yv6+adgXn7WfyJxW99
 Rkfm10ik4atUoWROsYWSp9BOXkT9dHuvDMCqLBEvCMLBUlaagGSedkoYAZ13SkVPZHQg
 Sw5i6MNjKckVoGZAagQAjmEmO/USZ7iKXDBTJsyEjrhF6bzAgfV3HgalZo1KUBwno/lR
 e+xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7tc9Q+/oTbPARSC8HT1obTGxa0LXINWPr1XyiGK25FFT/HXtRpaby7b/ZTMPiYCvtuuHmdBOR+Py8@nongnu.org
X-Gm-Message-State: AOJu0YwdPc7KIi0+bwLVSr+9tc//AhtFcoNjmP1egZUlWoMnAziybpu3
 V/T24r7k88QlQ5oeVOMUNRTrAds/Skfhbqlq71cwMJOBxhFc0Bn09MNME7535FOMWDYuW1A+WB8
 jJ9CFY0vX0DsJxIipKKCEAGKQFNySrpJsLYs+TRnvU2I0EyqXlfX1WEIC
X-Gm-Gg: ASbGncv57UYpRtxF94X3nxr2pmtvpSrEao1J7Xn2LVYEPtcFoZK15ny0RSWhy325XAB
 qxfn+s1dMqQnvzzAJy86F+RC2iSObAo6j/4oRRFxGxpQUbUh7BPFwDV93RTiDZur49r5OpmixBn
 xHLfA2/K4a7ifDZyKJBvWJ4NiFit0oqMF5Hv1igwx1Tdkq0xbQ+BVxWM93XOGR7Vr08kZxo+5Y7
 yOVQK3sFpXdhi4L8At8MLSrEmF3XnAJ2SeY3kSHDXAu0b2AloQUMqDSonzNLcfornwx1jjRcAo2
 SdJO9FwU51azWdsQYirjpz5Nq42Pmm8hPtocoh3O7OugpgDC+knyaRgmAsEssVIC/PTwFpG6M+4
 =
X-Received: by 2002:a05:620a:aa13:b0:7e3:49b5:d53f with SMTP id
 af79cd13be357-7e814eec6ddmr63987685a.34.1754424061405; 
 Tue, 05 Aug 2025 13:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgU3KGaF9lAXhF99U5wF/pQEmwfbpPx2Br1IGWuW8nwc1mWumfrd6/vkQrUAEw1GW69sG3HQ==
X-Received: by 2002:a05:620a:aa13:b0:7e3:49b5:d53f with SMTP id
 af79cd13be357-7e814eec6ddmr63983385a.34.1754424060861; 
 Tue, 05 Aug 2025 13:01:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f753489sm717889285a.77.2025.08.05.13.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 13:01:00 -0700 (PDT)
Message-ID: <82833ff9-1f78-4929-82d6-f59a3b056626@redhat.com>
Date: Tue, 5 Aug 2025 22:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2] hw/arm/virt: Include 'system/system.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250731144019.1403591-1-clg@redhat.com>
 <f9a79dda-83a8-4cbf-9a3d-dde4fcc0eb48@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <f9a79dda-83a8-4cbf-9a3d-dde4fcc0eb48@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/5/25 16:16, Philippe Mathieu-Daudé wrote:
> On 31/7/25 16:40, Cédric Le Goater wrote:
>> hw/arm/virt.c should include 'system/system.h' for :
>>
>>    serial_hd()
> 
> 3 other files miss it:
> 
> $ git grep -L system/system $(git grep -wl serial_hd)
> hw/arm/virt.c
> hw/isa/isa-superio.c
> hw/mips/loongson3_virt.c
> hw/mips/malta.c
> include/system/system.h

OK. This deserves a v2. Will work on it.

Thanks,

C.


