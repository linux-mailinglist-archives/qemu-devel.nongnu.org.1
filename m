Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D863EB0BCFB
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Jul 2025 08:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udkJh-0002Cw-Ec; Mon, 21 Jul 2025 02:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udkJH-00021q-GE
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udkJC-0004Hx-OV
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753080448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=re26V4MdoH7doDvWpiffRLGGSN2mEqo3D5YCQsHnsBE=;
 b=irLAbud3WmvftTd6WnPlHUDrWEOVNIbK6aWkGoUqFRL8yvAXFcIxfxxhPTOVohrXeHQQst
 oTF1ZPTUrNUxpsgmUC49+9Od31l7Kat3HjBVhguoXeAZ4nTAdCHK/Ea00a4TTv77JlfEto
 Ks7cQfVc/b4BuGEYJ5loJBZOWn8/mPk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-GrNXc9SHMxqkm6zrnPWKgA-1; Mon, 21 Jul 2025 02:47:26 -0400
X-MC-Unique: GrNXc9SHMxqkm6zrnPWKgA-1
X-Mimecast-MFC-AGG-ID: GrNXc9SHMxqkm6zrnPWKgA_1753080442
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so23656555e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Jul 2025 23:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753080442; x=1753685242;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=re26V4MdoH7doDvWpiffRLGGSN2mEqo3D5YCQsHnsBE=;
 b=vO0eJART7+5bTDVhh6NBYiuATejvbSE3b2QyJnMhomnYtUnipEkmU5rSkaI5FQLmmq
 KIL0uiZHf/0WRyEXco6+DXAMAt6nQ78trx9jc5PELVTaoPcH9t2jfN6mPRgrYQ6zddWB
 1TJVUC43xfq0JeSir1TLeWEr+zbjfq2BDuz1OVwb7eSuJO5ELALr539jSxbuivTy/qG+
 aQPKJQ9rUJOVo45Myc0VE4h8n4HojRTqPNdwAcey4m4+PkBAUIzxN3gn78YVfD7I5GZd
 j1hW25EJFPtuXFOvvjmrPxnS+70GryFUSM5OGckBeF5NnVVA7y2LOgge5AA7t24By/8h
 v5Nw==
X-Gm-Message-State: AOJu0YwKtn0DJMTHh3ACXDkgvwGYpp+M+5pRYV/D99ySmjoQQk6CHcEq
 axC1w53Im/kDliWiSLIA/sQHeKykH7OQdESMEv9XHSj2YzPBzyJ0Zj4wcUoU6YwNTCnB80TBxMM
 mNhis97djMMrTtx9Zxw6qaflBGWY7jYysIye2ugjFOCva6jMoOqzKYtJX
X-Gm-Gg: ASbGncuC6vX+PtX3L/t/Ju9OeaXlFUuuhIqrwgOTTXL5Yau7egMi29Nq7G7ZtUzl193
 VdllMkjZpfmO2usTAQGTZTCVyZLh0pukkfClFJCpn8Mt2mBsIh8MvhCQdxSIIlwTgD1e+eerFKt
 V/445XD0MW1RTjaYC4N0QuHAkO5mWV/PelAV6Xrs80JbvTKn/wpq+Oy0+GeOiZSq7gj1o5dHwzy
 bV7PeyVAl3ELlOfYZQtLlaHAcA+oZvOWzcMh98uLwKgGttgn5ShKqnS7diezbAWTyj1+yOskfJw
 o0lyWJGCRX2I2v0aBPVwgs8R5dNTL014FCoMT4cwHCxLRIKkLjdEaXyWZV5A6Y1h1PCAIrqX57M
 tYQ==
X-Received: by 2002:a05:6000:250f:b0:3a4:f63b:4bfc with SMTP id
 ffacd0b85a97d-3b61b217f24mr8617185f8f.34.1753080442134; 
 Sun, 20 Jul 2025 23:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEU+gpj+LgfiT/vEXJ4Ng8lh2xkLBb4QW4CfMNc/BCAdNBmbOIg0SO0jKyU8ep1jd5jm7txg==
X-Received: by 2002:a05:6000:250f:b0:3a4:f63b:4bfc with SMTP id
 ffacd0b85a97d-3b61b217f24mr8617168f8f.34.1753080441578; 
 Sun, 20 Jul 2025 23:47:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8860cdsm153545265e9.20.2025.07.20.23.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Jul 2025 23:47:20 -0700 (PDT)
Message-ID: <82ee6fab-08cc-437f-89fd-428a5d28b448@redhat.com>
Date: Mon, 21 Jul 2025 08:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/3] vfio: Move the TYPE_* to hw/vfio/types.h
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Shaoqin Huang <shahuang@redhat.com>
References: <20250718194349.65771-1-kraxel@redhat.com>
 <20250718194349.65771-3-kraxel@redhat.com>
 <4fff6291-7121-4b4e-b271-77b859206817@redhat.com>
 <ma53hy32octccy2wnq34hmcshgfyky3xj2rc75gu36rxhxkkoq@hbzm623ss4gc>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <ma53hy32octccy2wnq34hmcshgfyky3xj2rc75gu36rxhxkkoq@hbzm623ss4gc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/21/25 08:28, Gerd Hoffmann wrote:
> On Fri, Jul 18, 2025 at 11:03:40PM +0200, Cédric Le Goater wrote:
>> On 7/18/25 21:43, Gerd Hoffmann wrote:
>>> From: Shaoqin Huang <shahuang@redhat.com>
>>>
>>> Move the TYPE_* to a new file hw/vfio/types.h because the
>>> TYPE_VFIO_PCI will be used in later patch, but directly include the
>>> hw/vfio/pci.h can cause some compilation error when cross build the
>>> windows version.
>>>
>>> The hw/vfio/types.h can be included to mitigate that problem.
>>
>> As said earlier, the string literal "vfio-pci" could be used instead
>> of the TYPE_VFIO_PCI define and avoid the extra vfio header file.
> 
> I think it makes sense to use TYPE_VFIO_PCI, for consistency and to
> avoid typos in the device name.

We should then generalize this practice to all types.

C.


