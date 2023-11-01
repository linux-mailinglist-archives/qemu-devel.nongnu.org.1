Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77D7DDDC5
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 09:37:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy6hm-0006fA-0X; Wed, 01 Nov 2023 04:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qy6hi-0006ch-53
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 04:35:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qy6hf-0002q6-Qx
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 04:35:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b5e6301a19so6583238b3a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698827753; x=1699432553;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4PZFp14IYzQo0B0uHIpmTW9p+9pV9WLTUtKd18ITaOg=;
 b=LJ0GwLVMDFaNAeYjoYt6cLKk9qUxgS9tlVlp0caWl3Sm+8GLWqVchvivadLF0f9vuz
 z2NWiSRYPL7v0pCGKVOYQ24Yih+igAdA0CZDxI+tnKgWLuzt0a6Jkhoxi9EmhGRo3jiz
 VkF6gf8ML8BM1rRBJYYNuVywSfwAwFehJhOQLgbyq2l8btRCvZjp9KG08Ntn0bo+bKTD
 77Z2Z0nUAOgw4pC+lDhmDMRtVVSSQktoRNGOUluGshfORoC9Z4UE/NJlg8dsyephTihF
 N2oSNdq28R2QvQpu33MqmexeZP0Q49OEwQ7v4L+aXVBpFyK3VRaszjtbLO1IXJNKNz0M
 9r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698827753; x=1699432553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4PZFp14IYzQo0B0uHIpmTW9p+9pV9WLTUtKd18ITaOg=;
 b=wA2B8/F2HM67hka60v41VJ53+M5rdyaIoH8GpSopD16hKPabT2Hu+1Ao5CCiaLx85z
 T/wpJYHX30SOtddGKAbL3mW+9EXIh4wDzxCT/misUs2KOKvujmCG+fEaknOqytAj4E97
 LWDwGwbLmiblx2YEMPGYYndAQ/YzwOArGZodx+tZDQz7saaN2BfOKIrSGzW2RXyHl+X7
 U00k/OQ8z/WJ0QS80dzzHoohIwTbZ4T0KS9yFVLabG2Hi7gbG9Xx5QGWz7aBgeIN1Vng
 YwYmqX6CWm2Ib1Zs2PPWiATBJ1L+owXn4/JNhIFPJOhvH4VJ4T5w7JimqglCVQQfIX2k
 nQRQ==
X-Gm-Message-State: AOJu0YyTDXgXoEoBzh2+ieanOOfMaylI1+DQGA6sKhJLYqRmYwOxVmYS
 FDwfTHV2llddxTfrst89Ka2jug==
X-Google-Smtp-Source: AGHT+IFxPGTjMt8DuiowXct30i9/r5Oc/NDmcyBt34pzDnISgJC2Pj+bpEinhxE5oN5dGE7xNSYA8Q==
X-Received: by 2002:a05:6a20:8f18:b0:162:ee29:d3c0 with SMTP id
 b24-20020a056a208f1800b00162ee29d3c0mr19744500pzk.42.1698827753338; 
 Wed, 01 Nov 2023 01:35:53 -0700 (PDT)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 bb9-20020a170902bc8900b001bc2831e1a8sm861076plb.80.2023.11.01.01.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 01:35:52 -0700 (PDT)
Message-ID: <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
Date: Wed, 1 Nov 2023 17:35:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 Andrew Melnychenko <andrew@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
 <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231101023805-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

On 2023/11/01 15:38, Michael S. Tsirkin wrote:
> On Wed, Nov 01, 2023 at 01:50:00PM +0900, Akihiko Odaki wrote:
>> We had another discussion regarding migration for patch "virtio-net: Do not
>> clear VIRTIO_NET_F_HASH_REPORT". It does change the runtime behavior so we
>> need to take migration into account. I still think the patch does not
>> require a compatibility flag since it only exposes a new feature and does
>> not prevent migrating from old QEMU that exposes less features. It instead
>> fixes the case where migrating between hosts with different tap feature
>> sets.
> 
> When in doubt, add a compat flag.

Personally I'm confident about the migration compatibility with patch 
"virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT". virtio-net already 
does the same thing when the tap implementation on the destination 
implements virtio-net header support while the counterpart of the source 
does not.

