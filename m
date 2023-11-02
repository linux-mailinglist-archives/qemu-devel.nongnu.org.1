Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 800D27DF56D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 15:58:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyZ7e-0003k6-Mg; Thu, 02 Nov 2023 10:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qyZ7b-0003j2-W4
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:56:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qyZ7Z-0002Br-Rc
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:56:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc2f17ab26so8296355ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698936990; x=1699541790;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/YjG/7Xcb/G67jCrNXb/iPzgXwcomh/COsWcoh+KA4=;
 b=xkSbRy+/ziAkF7p/8Q84QcEGBf+G50alnenG+pT+oqEi2P82NW+95fJmvXDB+MiBvo
 935Piyu2KtsTL9I/91ILyv/8e1VP7P5+YMJPdjnru9qHvWElxAJ3kbT2gQGH7TJt77l9
 LTmsv8IJxDoIm5nxD+gmjAN9trZSJT4MN9Ng5sBawcIxa2kyqHtUkwnTMQo1FXN0nGbk
 AM2WV/OAka5/O8SaOMgI6qn+NPIaSRIwDkS4dFHiVxxkxAnxbtZPVMgBSRbIWJtEvKtr
 83vNahjg7Mn3j1CCnplGYRHNs4pfwmVBXsL0CJUeZE3SUVMDBfO1EZAFtsAMo5Eygt97
 tcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698936990; x=1699541790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/YjG/7Xcb/G67jCrNXb/iPzgXwcomh/COsWcoh+KA4=;
 b=oXmfLTYPg2+YyRr1BI1w6OPUO32S8YcU8381pgp5Lbap5hG+kRCNcKhjhVDOCRityL
 0rX/joOLL8/nJOIFdhTcg8hukY2pVQiyXQVUrrJKji076ZRydtMRKpMmngfhuEELPF2K
 Feq4Zhl6NnOjFYzmVCtTn4Og1BtgD4x9rTbyKNB9zG6WT9D3bHJB1le58eyEQF8JkZ3O
 29NCNZLXQhfjCMWZQ75yuy7JvAoLcXoWNDq7k2VwJ414Jj0ienh7pyvDiVz0P6OgGc9W
 /m9XhnMWsexM45iaYt1CveZnv4usDMJYAr3AZ3QLSUzVupRPWYPAdGTAk4OaquRTL7jF
 htow==
X-Gm-Message-State: AOJu0YzTm+/bYwLD6Qf/megnT5SdyNZHxKceUtpvpdBqRxGop5rK+VaU
 YBL4BBUESJXxhufaGu4fJQoEuA==
X-Google-Smtp-Source: AGHT+IHJY7ZNUobeElthS+JHGdxCldX3d55m/QlSvm0peK82nHdWrXZI9bXFF+czv/KykfZajAOr3Q==
X-Received: by 2002:a17:903:22c5:b0:1cc:4669:c0eb with SMTP id
 y5-20020a17090322c500b001cc4669c0ebmr11499594plg.21.1698936990281; 
 Thu, 02 Nov 2023 07:56:30 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a170902db0100b001c88f77a156sm3355plx.153.2023.11.02.07.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 07:56:29 -0700 (PDT)
Message-ID: <2fbdee21-60f4-49ff-b61b-923c895f90ba@daynix.com>
Date: Thu, 2 Nov 2023 23:56:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Andrew Melnychenko <andrew@daynix.com>
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

On 2023/11/02 19:20, Yuri Benditovich wrote:
> 
> 
> On Thu, Nov 2, 2023 at 11:33 AM Michael S. Tsirkin <mst@redhat.com 
> <mailto:mst@redhat.com>> wrote:
> 
>     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich wrote:
>      > Probably we mix two different patches in this discussion.
>      > Focusing on the patch in the e-mail header:
>      >
>      > IMO it is not acceptable to fail QEMU run for one feature that we
>     can't make
>      > active when we silently drop all other features in such a case.
> 
>     If the feature is off by default then it seems more reasonable
>     and silent masking can be seen as a bug.
>     Most virtio features are on by default this is why it's
>     reasonable to mask them.
> 
> 
> If we are talking about RSS: setting it initially off is the development 
> time decision.
> When it will be completely stable there is no reason to keep it off by 
> default, so this is more a question of time and of a readiness of libvirt.

It is not ok to make "on" the default; that will enable RSS even when 
eBPF steering support is not present and can result in performance 
degradation.

We will need OnOffAuto instead of a simple boolean value if we are going 
to enable RSS when eBPF steering support is available; "auto" will be 
the default and will enable RSS if and only if eBPF steering support is 
available. "on" will not be default so it's better to validate if RSS is 
available when the user explicitly specified "on" for the "rss" property.

