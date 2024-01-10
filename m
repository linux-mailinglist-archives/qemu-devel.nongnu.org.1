Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B0829556
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:45:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUCH-0005AC-09; Wed, 10 Jan 2024 03:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNUCC-00059e-Kp
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNUCB-00058J-2I
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704876257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=609N03LdjpkxAYKf0CfIMFNH4ZnJqwVCDxCBxZ9EZlM=;
 b=MCm2JSzcXit1wb0r7qGW6c/e7EZAh4Pngk//9hEkWnKQzilF3HCD5gQTwLXRrYWP7Loui+
 tG0/i6f/yRJoue7nc13tgZ/YHATHo1gJOXA5hvEz5BzkAwxm9DrgBFXvqCb1SsiMd6D062
 yY2Ho/ctaKFYYKZ8ExBhsDHpJw223DM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-W7gUsjCwMFOZilxFPCoF0A-1; Wed, 10 Jan 2024 03:44:15 -0500
X-MC-Unique: W7gUsjCwMFOZilxFPCoF0A-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d53d51c62aso5751085ad.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704876255; x=1705481055;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=609N03LdjpkxAYKf0CfIMFNH4ZnJqwVCDxCBxZ9EZlM=;
 b=TZNwvIL5QVYhdzDv5CC0KqJQXNJ2dXPsArpCVMZ6/RTdram3K83zb4gmOC3HhHHUtU
 +eD8unEh58017nAxoLgf9kFiPcMC3lrbgkOV0Q4cpUwznVHh36WG0oTr9FdVMJQrCfkO
 Uq5uq0pQlh1eX9qRD3DnNyTjp5RQeoUTYRF7bMzV1gimWr60F0F+9SCtT/832vqrKQ9l
 Kziinp5KxMYXFk9vGb8XtnFkLLdBIWHxgXXQh0YeJ7LPpsAjGja/MZoNQmMecwNwfjrD
 QuGRVTBUhpMbvbui0t8DOGDdEJK68bGlM0x8tKIqyZ/x4bV8+0Fu/zB7J7HrUBo6xEqN
 JYmA==
X-Gm-Message-State: AOJu0Yweml6KiXX+w3TppMhPQShTTqLUJk5m35MLPM+IA3aqMqBUzgmP
 9WrZ345vjX0zw/T8d98XERVM8D/cQie8NpvNa8nlcwaAJeyc5XYyCanSCCc2uS4M8bHkZe6wn6E
 xaWoAD7KjJBzWuQ9LX5i9Oaw=
X-Received: by 2002:a17:902:7297:b0:1d5:4c03:9988 with SMTP id
 d23-20020a170902729700b001d54c039988mr1289587pll.2.1704876254846; 
 Wed, 10 Jan 2024 00:44:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMlRiiPdA3rkz3DsPFdBNYCLGtX9b99x8506hBP0HXztw/G3GkX86Ay3fyQ3wCYhLqjq9sjQ==
X-Received: by 2002:a17:902:7297:b0:1d5:4c03:9988 with SMTP id
 d23-20020a170902729700b001d54c039988mr1289560pll.2.1704876254547; 
 Wed, 10 Jan 2024 00:44:14 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709028c9800b001ce5b859a59sm3089659plo.305.2024.01.10.00.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:44:14 -0800 (PST)
Date: Wed, 10 Jan 2024 16:44:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Message-ID: <ZZ5Y0UMA2h2x_tb9@x1n>
References: <87y1d6i47m.fsf@suse.de>
 <597186d9-af21-46e8-8075-f21d36c01c07@kaod.org>
 <87plya76cu.fsf@suse.de>
 <d5c0b9fb-8b09-4f68-b3ab-c8adffd484a9@kaod.org>
 <87bk9u8dhs.fsf@suse.de>
 <2fa344b7-ccd2-4e6a-8c32-5ad7e4c960d6@linaro.org>
 <ZZ4Qrfis4XHWGN0j@x1n> <87cyu9hgit.fsf@pond.sub.org>
 <ZZ44iQRPrdDpfov7@x1n> <87sf35ehio.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf35ehio.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jan 10, 2024 at 09:09:51AM +0100, Markus Armbruster wrote:
> If an object has state that needs to be migrated only sometimes, and
> that part of the state is large enough to bother, we can put it in an
> optional subsection, can't we?
> 
> Destination: if present, take it.  If absent, initialize to default.
> 
> Source: send unless (known to be) in default state.

Hmm.. correct. I think I messed up VMSD's needed() hook with field_exists()
of the fields; my apologies.

The trick should be that VMSD's subsections is more flexible, due to the
fact that vmstate_subsection_load() has:

    while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
        ...
        sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
        ...
    }

So it tolerates the case where the subsection doesn't exist, or out of
order subsections.

While field_exists() hook seems not that flexible, as it's implemented as
this in vmstate_load_state():

    while (field->name) {
        ...
        if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
           ...
        }
        ...
        field++;
    }

So that vmstate_field_exists() needs to be known even on dest before the
main vmsd got loaded, and it should always return the same value as the
source.  Also, the field has ordering requirements.

Then yes, subsection should work for dynamic objects.

Thanks,

-- 
Peter Xu


