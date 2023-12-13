Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8D28114B2
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 15:34:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQIc-00004u-I3; Wed, 13 Dec 2023 09:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rDQIZ-0008WI-GW
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rDQIX-0008QZ-9D
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 09:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702477992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xck2aJWh555yW0RZMjzwD1pMZqz0dj26lq7MGRksVsE=;
 b=aguVwLTa+62/KOjbNyLU2YfefLBD3eD5Bf+luqAveP+2RTq879tFYfnrQDSaxyef6TX5KE
 yK0+AKo2CoRx5vgS75eauBkLQxUEZXARwBTtaqzXHn5vxgcJBmOoRG1pNlq9aJud9JVD2e
 0dZDeoWeaY3B2lw7iV0UpmqpQLflvyg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-ZmqaB4uXN9aLjjW4HDKFhQ-1; Wed, 13 Dec 2023 09:33:11 -0500
X-MC-Unique: ZmqaB4uXN9aLjjW4HDKFhQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a1fa0ed2058so211703466b.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 06:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702477990; x=1703082790;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xck2aJWh555yW0RZMjzwD1pMZqz0dj26lq7MGRksVsE=;
 b=fnW2FNN1vsj7sLNbvqwvodNxP4fMvXLPadKSPXmTKAK7EMr+mRfcJ/ciuTRcdWj36I
 lZm2KtO8olOnF3O/RUqgKLAfo0MiuTcgMXWDp7KunoA0SgbVFo9us4blBiDL5EuM2nWF
 4e+mLlLJBi5n7XoCKa/j2AryKOqVYkXLsb66Iq0RP5oYeVsdBitIBdfwPvRYftYfmHWK
 K9qCmuTv5lqadbdfBGs8yAp3cLMXHyjeaZII4I+5asXZ6BbLMKjrxKf5KkYVktoCAI6q
 KjQ9D54qaV/Kg64Xvf0JP7Hq3gGeoH2C8/Vk1MCG6mQVyX/MbaB/rmiKEOlbg9MRfv8z
 TMwg==
X-Gm-Message-State: AOJu0YxBwmu6eAtgHB7pp+J4BQxpbXFXuBxsu3BvTUuL+47O/2SBFNlJ
 gVKtInv3lvgyuOPPs4Wht3Bg/4xmjF/HmdTNug9+4NOYcaZ9iVTgA4PxyEoXskTWzpTy6EeYoTa
 vxHBtBThd3Ytyl88=
X-Received: by 2002:a17:906:dfeb:b0:a19:a19b:4273 with SMTP id
 lc11-20020a170906dfeb00b00a19a19b4273mr2706179ejc.222.1702477990035; 
 Wed, 13 Dec 2023 06:33:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL5l8IjTceiNBmu0iqwWMkzgL3ZWa8Q/zZvleaGSy6AoUTIGD1G6Z+k6HNX0OYz9WewtS9bQ==
X-Received: by 2002:a17:906:dfeb:b0:a19:a19b:4273 with SMTP id
 lc11-20020a170906dfeb00b00a19a19b4273mr2706175ejc.222.1702477989708; 
 Wed, 13 Dec 2023 06:33:09 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
 by smtp.gmail.com with ESMTPSA id
 vw18-20020a170907059200b00a1712cbddebsm7831175ejb.187.2023.12.13.06.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 06:33:08 -0800 (PST)
Date: Wed, 13 Dec 2023 09:33:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 6/6] tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp
 changes
Message-ID: <20231213093242-mutt-send-email-mst@kernel.org>
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <20231213105026.1944656-7-kraxel@redhat.com>
 <AD96681F-FBF0-4AB9-8F2B-5B6C1FB5A52F@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AD96681F-FBF0-4AB9-8F2B-5B6C1FB5A52F@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Dec 13, 2023 at 04:24:24PM +0530, Ani Sinha wrote:
> 
> 
> > On 13-Dec-2023, at 4:20 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Please combine this patch with patch 5. No need to do this separately.


Yes but since it's done - it's fine either way I think. No?

> > ---
> > tests/qtest/bios-tables-test-allowed-diff.h | 1 -
> > 1 file changed, 1 deletion(-)
> > 
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index e569098abddc..dfb8523c8bf4 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1,2 +1 @@
> > /* List of comma-separated changed AML files to ignore */
> > -"tests/data/acpi/virt/SSDT.memhp",
> > -- 
> > 2.43.0
> > 


