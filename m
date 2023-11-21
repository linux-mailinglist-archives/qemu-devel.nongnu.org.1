Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB627F31CA
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:00:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SEc-0006IV-6R; Tue, 21 Nov 2023 10:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SEZ-0006GE-22
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SEX-0004X0-H3
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700578813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gX7TNBdR1Ub8HS1GbOmBzOld4fPPhfpNx+G4FSWwALc=;
 b=KXwqya8zBrKoSjUNPxGeRuWVqFwsjja6PbstcvXLHxhnSOAMNUcXgBf8SdidDQtkMfh/XN
 HAp4deQak3zUWkRumDPDpJ/YXaTX1fiPuhei4rMlP4OZbCzdBKQN/ASwKTnNOsLKu8ggrU
 kJczl9mnQsFyVLnhgFNuZYlZs3TzSns=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7Be7H220Ogy8MdePefiBnQ-1; Tue, 21 Nov 2023 10:00:11 -0500
X-MC-Unique: 7Be7H220Ogy8MdePefiBnQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1f93a01ef88so736334fac.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700578811; x=1701183611;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gX7TNBdR1Ub8HS1GbOmBzOld4fPPhfpNx+G4FSWwALc=;
 b=lrR7yrXtiia/+4Sm1jtlC/SgHpwdawTo+H7YcGmJ01zIziIQ3FkWKnz6koXze8XQVY
 U6av+dp0Iq+aQUb0lWBbiLu44cfsejUoKaafVZcSIZ/fq4dikB2qspO1WID+cqiejjJq
 x9ke6IrAFa0vQ6xw0kjfLhYJyhRspoFWzK6D+q59peGvhefExecRyUUsxGMRdfcVyXJa
 V94fZuzuddcJ1+E4PJELNpqcZXdqYjP/bPq3DDWKaJJMZ6+tTCoNciwSTPQzOZbPr8wT
 NGo32IXLpv3CNEKE7f689c2sXLYmt5cGNPDM4GnSd9IY1AXFIlq9QFVtbit4jdRNcKeL
 fPgw==
X-Gm-Message-State: AOJu0YwLyImRyrx3Ot5yQyxRi2TJd+me1NxaFP1BFZyPwTfYUbXj2dWP
 2K3rvZfAxGM2bWfF4FGz7wzJgLSKe+ElMMzxXP/63ClymGb5OAbZGh2oS6umME5RcG+KadY03lA
 4er00C51NieC5llQ=
X-Received: by 2002:a05:6871:2304:b0:1f9:5d11:cc7a with SMTP id
 sf4-20020a056871230400b001f95d11cc7amr4074712oab.3.1700578810757; 
 Tue, 21 Nov 2023 07:00:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqEvsvEg5nytpFj4L9FNYrod2OLCR4eB5EOK38ANPOc+JVSXn0HXgFP2uZXnMp0eaQxpF00g==
X-Received: by 2002:a05:6871:2304:b0:1f9:5d11:cc7a with SMTP id
 sf4-20020a056871230400b001f95d11cc7amr4074696oab.3.1700578810521; 
 Tue, 21 Nov 2023 07:00:10 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 kd13-20020a05622a268d00b004181c32dcc3sm3645147qtb.16.2023.11.21.07.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:00:10 -0800 (PST)
Date: Tue, 21 Nov 2023 10:00:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH-for-9.0 09/25] memory: Simplify
 memory_region_init_rom_device_nomigrate() calls
Message-ID: <ZVzF-FinQd_1-U6r@x1n>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120213301.24349-10-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 20, 2023 at 10:32:43PM +0100, Philippe Mathieu-Daudé wrote:
> Mechanical change using the following coccinelle script:
> 
> @@
> expression mr, owner, arg3, arg4, arg5, arg6, errp;
> @@
> -   memory_region_init_rom_device_nomigrate(mr, owner, arg3, arg4, arg5, arg6, &errp);
>     if (
> -       errp
> +       !memory_region_init_rom_device_nomigrate(mr, owner, arg3, arg4, arg5, arg6, &errp)
>     ) {
>         ...
>         return;
>     }
> 
> and removing the local Error variable.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


