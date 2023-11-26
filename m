Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB487F93E2
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 17:35:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7I5f-0005Uz-G6; Sun, 26 Nov 2023 11:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r7I5a-0005Uj-Ms
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 11:34:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r7I5Z-0000wt-4n
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 11:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701016471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6zz08XO0cuJ+t2aMNuheukr4zb6gRPQmVGpxugKtoFU=;
 b=WISwTQ7adnjua59q6k7h8SJkUYrYRCZuYc52elNJ+pRmoQ3V/aPkYlHl1DbTOr26ZO7dTU
 A6TrtXGmwBfCrgg/Bh3shB5WLbToVh48/WTlnKghK1lh9Xme1uwBWwznQ9fnN+aQivrM+o
 Qdx/QfIJQ26QJAl6sJLNzY09BJ+odvU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-3kBXlrxhNLue_5Ods-ovxA-1; Sun, 26 Nov 2023 11:34:30 -0500
X-MC-Unique: 3kBXlrxhNLue_5Ods-ovxA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a0c510419caso63048366b.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 08:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701016469; x=1701621269;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6zz08XO0cuJ+t2aMNuheukr4zb6gRPQmVGpxugKtoFU=;
 b=gA6NuLQxHBbaeIm7gSN0ERQvOzZcugnykMaxNwU3ctfqsQQsxHRAqNe0YvmO0PrLxw
 VtXCTLFXVaMJyr1RkqGQV4NucWkdj7UK/beyFCnX1YTKPdNYFTJuv7brdeGJSMDhX7Nq
 KhHgUIvY536QUC3X1+9BV2mbw1dA6Y7lIf6c+iYoPzV6N2UiIA8xWY87qWou5Pj3H7rq
 dHfOh2g2XjznXCeoDUWrfoAkIGRo/KaaKXiB22hKKqHNi9J5xdGk2BL7OWfXl46pdjpX
 WXuauf6a4gV2MiEIHv1XmoG3XR/nvPFZmgrv+6Qz3X+T99O/2hdCZ7to1ItkOPxLSFHv
 EEfA==
X-Gm-Message-State: AOJu0YyjAKEXJD8UUJJuoPox7E0Ee3fLjPAGH7cYtba/XX8nD1AAmAWm
 vZ6zglGWaIiGyeIt2dH/s6eXOkaerj+6jtSKKaFbgU+qCl+fHRP7UZqJ+sbDcMdefbVCm4Tg17z
 jgdsSccG9SyrKT5Y=
X-Received: by 2002:a17:907:1387:b0:9e6:393f:465e with SMTP id
 vs7-20020a170907138700b009e6393f465emr5715547ejb.31.1701016469015; 
 Sun, 26 Nov 2023 08:34:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrzKbEO89Hv4rnGVZXkwfTxM2jj0gH1Sus/2Ung1/NvbW1e+5cQ3g27aNz3d/WktPG0czH7A==
X-Received: by 2002:a17:907:1387:b0:9e6:393f:465e with SMTP id
 vs7-20020a170907138700b009e6393f465emr5715535ejb.31.1701016468741; 
 Sun, 26 Nov 2023 08:34:28 -0800 (PST)
Received: from redhat.com ([2.55.10.128]) by smtp.gmail.com with ESMTPSA id
 bq23-20020a170906d0d700b00a0d02cfa48bsm1331089ejb.213.2023.11.26.08.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 08:34:27 -0800 (PST)
Date: Sun, 26 Nov 2023 11:34:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Subject: Re: pending hw/audio patches for 8.2
Message-ID: <20231126113336-mutt-send-email-mst@kernel.org>
References: <20d1b5db-c931-49af-af91-9de1af074fa7@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20d1b5db-c931-49af-af91-9de1af074fa7@t-online.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Nov 26, 2023 at 02:32:43PM +0100, Volker Rümelin wrote:
> Hi,
> 
> there are five pending reviewed hw/audio patches for 8.2. They are all
> bug fixes. It would be good if someone could send a pull request for
> rc2. I don't think Gerd will send it.
> 
> The five patches are:
> 
> ("hw/audio/hda-codec: fix multiplication overflow")
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg00828.html
> 
> ("hw/audio/hda-codec: reenable the audio mixer")
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg00827.html
> 
> ("hw/audio/virtio-snd-pci: fix the PCI class code")
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg02084.html
> 
> ("virtio-snd: check AUD_register_card return value")
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg02545.html
> 
> ("virtio-sound: add realize() error cleanup path")
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03878.html
> 
> IIRC the last patch needs a rebase.
> 
> I omitted another reviewed patch, which is a variant of
> ("hw/audio/hda-codec: reenable the audio mixer").
> ("hw/audio: Fix logic error in hda audio")
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03951.html
> 
> I have a repository at https://gitlab.com/volker.ruemelin/qemu.git. The
> five rebased patches are in the hw-audio-fixes-for-8.2 branch.
> 
> With best regards,
> Volker


OK I will pick these up. Thanks!


