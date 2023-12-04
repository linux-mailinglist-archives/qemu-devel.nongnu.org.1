Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF13802B37
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 06:07:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA1AW-0005pn-LL; Mon, 04 Dec 2023 00:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA17O-0004H2-Bi
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:03:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA17L-0001og-K8
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 00:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701666219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZq2v+FtG3wM+wjlS7ZD9iX9qkh+sFO3YmNweXM0DXE=;
 b=HxYQ4hTWBe3k1cV1FAQr1uiuI7cdRrY5+5FdMObgT3qPuiYZCqYw2ir7bWyTlXyTB4duWB
 GsGO9cJg68/HUvhcHCDO8OEvvas1v7dxYJadp7DHnNl17VT5LEPmWtfrJSAa6ke4d6HOC2
 Ffg/jdo6h7HfRJ/CBYDHh3tK/B9L7ko=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-seNfaLdyOyygdODv9CGfTQ-1; Mon, 04 Dec 2023 00:03:37 -0500
X-MC-Unique: seNfaLdyOyygdODv9CGfTQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d09caea9e3so2690315ad.1
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 21:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701666216; x=1702271016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UZq2v+FtG3wM+wjlS7ZD9iX9qkh+sFO3YmNweXM0DXE=;
 b=wBeB9lsw4Ux3J4cqmetp0URZ2uKU7OFX4gC0zsG/Up24J/DOGanqqmO7Ndkf4f4c1O
 B9/CShwxukbexxvHZFGmUdOwuyRBO/1K03XxeAVlDFeEqvFT4XmEdaOjifgooHNWeE1v
 xd0UaxhlkVuKgHXusgn9aZ/G4Rin4kgfbctSpwQ6zNcmKec9ywGgQ2YfNSmxsT+iwxfe
 htfD8QQVl0LH3t2N3hj1vtgAcI6FkY35LBdO3ID2/tIqxrn2tDxICi0Mfwgh+GQLfP5V
 DUpGjjXLyTRxhS3af27IkI+KeQNPGqRORumUdbavJYdo4bq5oDwPCP2xY+0xnmQ57fna
 lJZg==
X-Gm-Message-State: AOJu0YwC1LEWd76rVKpi912MbwavU3L8NcrpAGvkIVIYNAwWsExIB6ET
 wmIB/MCVauwar++fDtECkOPraCw2LeCK+TdHfIRpWGDKUgt8lBHkUuFUvWYuqjYeqnbElc6grPE
 qzg5vOo5LyYfZLnvOdgFhR/s=
X-Received: by 2002:a17:902:db04:b0:1d0:7adc:1af0 with SMTP id
 m4-20020a170902db0400b001d07adc1af0mr707957plx.35.1701666216426; 
 Sun, 03 Dec 2023 21:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYNLudjsBqqVhFwjd6B5bUTt3KmE1i7xV5H+kghzdD5f4BYz+0PIot2Kn+Tf2tscP8TRlsYg==
X-Received: by 2002:a17:902:db04:b0:1d0:7adc:1af0 with SMTP id
 m4-20020a170902db0400b001d07adc1af0mr707951plx.35.1701666216120; 
 Sun, 03 Dec 2023 21:03:36 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.21.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 21:03:35 -0800 (PST)
Message-ID: <22c0650d-40a8-464a-9739-8f31815c2027@redhat.com>
Date: Mon, 4 Dec 2023 15:03:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 25/25] hw/pci-host/raven: Propagate error in
 raven_realize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-26-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> When an Error** reference is available, it is better to
> propagate local errors, rather then using generic ones,
> which might terminate the whole QEMU process.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/raven.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


