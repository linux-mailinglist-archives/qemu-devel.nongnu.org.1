Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C16707F0B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:20:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbfo-0007z0-V6; Thu, 18 May 2023 07:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzbfn-0007yp-UQ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzbfm-0007hD-IK
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684408794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UUcZWhlig4K+IT7Tw0VPSDzBjKAMB0imkoYeeaIx95g=;
 b=enXaXbxDH0IaHnyfV+Unb6uirOtmtFT6DmXtF5kVWEFOsy0xmWhgR6zik1XPtkBrc0bcGI
 BtDrBga01bRz2cx9veJWsI/4su2czS3ftZRlqHX7mWAjlxvGQnfaojBo+TYnvBFr29x10b
 0gTryCrUGzHi/3LU9tbtfDkSTOFOKIg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-kajw8ZhyMm2F4gkasJqkLg-1; Thu, 18 May 2023 07:19:52 -0400
X-MC-Unique: kajw8ZhyMm2F4gkasJqkLg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1ae7040632fso2447105ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684408791; x=1687000791;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUcZWhlig4K+IT7Tw0VPSDzBjKAMB0imkoYeeaIx95g=;
 b=AB/ThFZQ6KRp1uB9TCMvj1dtwGEcBymsgTql5kN9M2Wq6Kr8y76GixpHIe5gP0Vy7C
 MM6HBAgOGbP4k0rl/qs2ce9zwQ1D+shfEEYV5gdTdX2aj3CJflW3ZJ7ICMa5q9LKQr4S
 xcoHw/TKuR1WDqtNnG53p/ZGb+EtOCUPEmQhzJufMpHOPvfbhXOHIhaaZZ61pL3uOkOZ
 U7nEeedx++2d1j/sB4NF4kpsFX3Zcl444DB+EASPaODygPGJ9MRwDncjdSm7PTWuxYTN
 2xURqS4qpClE3fM05cBs4X+GCgidPfX4Xh0oyd/Llj9KLqkmSuPlLoExfLSpz3nvuV0p
 09PA==
X-Gm-Message-State: AC+VfDx8v0/4MweroVqLBADaM1vq2a3Jymll10U9sY97A8tfGbOQxfgP
 72FTxAID4awtVv3WmXYvwfg0pA8NI4K6Ux5YJZQYU06cXsuDmllHBvFqUFdLj3jTDqJ3EyalHC0
 jlr/47lLmVkPaZ0s=
X-Received: by 2002:a17:902:d511:b0:1ae:10a5:8349 with SMTP id
 b17-20020a170902d51100b001ae10a58349mr2274564plg.23.1684408791659; 
 Thu, 18 May 2023 04:19:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZFa3qL7nIj4LFu30odV/hO2c0FfPiKM4ShDpGOe09zKiqapOMWcp6hcJnzHhwQoflZZUQ+Q==
X-Received: by 2002:a17:902:d511:b0:1ae:10a5:8349 with SMTP id
 b17-20020a170902d51100b001ae10a58349mr2274538plg.23.1684408791286; 
 Thu, 18 May 2023 04:19:51 -0700 (PDT)
Received: from smtpclient.apple ([115.96.106.170])
 by smtp.gmail.com with ESMTPSA id
 li12-20020a170903294c00b00199193e5ea1sm1187239plb.61.2023.05.18.04.19.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 May 2023 04:19:50 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230518063559-mutt-send-email-mst@kernel.org>
Date: Thu, 18 May 2023 16:49:46 +0530
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <56051E30-DEB6-463D-AB4D-427795C40A77@redhat.com>
References: <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com> <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org> <87r0rflzd4.fsf@linaro.org>
 <20230517120710-mutt-send-email-mst@kernel.org> <87ilcqnckm.fsf@linaro.org>
 <C2CC04A8-F0F1-4360-ABF0-1F8DF7768AB1@redhat.com>
 <20230518063559-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 18-May-2023, at 4:10 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> he annoying thing with both these approaches is they work
> less well than current code since iasl won't be invoked
> at all if you do not remember the magic variable to set
> or flag to pass. ATM it is self-contained.

We could address this by a log message just like we do today[1] by =
telling users to use the environment variable.

1. "to see ASL diff between mismatched files install IASL, rebuild QEMU =
from scratch and re-run tests with V=3D1"=


