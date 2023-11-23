Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A861A7F64E7
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:08:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DAW-0000gz-Ln; Thu, 23 Nov 2023 12:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6DAV-0000gk-8R
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:07:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6DAT-0006hC-UD
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 12:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700759227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOlfZZ21Np9fk3R04gDNEgnZIe0fbJxH2epzktkXelg=;
 b=hoYtteqh1Eu51nA0oGOnmknEGRHZe0lH4gF7uU+n0nG7rg0g+5/FzMd6ufdxZlfbxLSCAw
 tz7gq4mZ9bVHL9+h0hzhnf7vIHIURWwsmLx5pZwEsGTSic6maxA7gu37kJsvaQH6S1Iqar
 cM77hVBYkmtUI6rkufwgkRUlY7plOqg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-maoJSpEiPfKh9QJiwM9CsA-1; Thu, 23 Nov 2023 12:07:06 -0500
X-MC-Unique: maoJSpEiPfKh9QJiwM9CsA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32f8371247fso492674f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 09:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700759225; x=1701364025;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qOlfZZ21Np9fk3R04gDNEgnZIe0fbJxH2epzktkXelg=;
 b=eQ4YeSEBzjNoLB/lkptRA3S/eZ/yhPEtBpsxIwdExzKOwjqSnzYqf2DZQe+rn2NozY
 Is32/qLZrJn/RnNz/ZAiUHk8l8bXEe1a1y4snbU0oxgnibbZTukK4/S7KAZTVMkSAxTs
 Ka42KFtLUqvfBDxJ9JNSpHUu0rylQwTzvOqtS7lEo/bdlHwNvGt2QnJs54WYpz0D2yqr
 eNGG+PSh3tDh0HOGvA2/IrTXj91hsQSgxzhSdazpP1uODBBdhf+BJFUQUAlQkgX9vxnP
 GEb6EJCQv98cZIrszFH+LY9/x+VYcorSxB+mX5f5hglG2wQn45bvrDlf5nBkXUsnzm2m
 oNQw==
X-Gm-Message-State: AOJu0Yy8/2wAwNKQxJ6CR2hG76FfdOaADbm0W+Sc/XECbvLmczvERXON
 d3mrwRz+XgifJrs4LZB1nLvGnc5vKE5oyu8ubU6r+PinHeQWQE1VjhaHT/bjxxY2Ii/7tb1rukB
 EEvbBIlKKyKJqjt4=
X-Received: by 2002:adf:ee8d:0:b0:32d:96a7:9551 with SMTP id
 b13-20020adfee8d000000b0032d96a79551mr48328wro.36.1700759225143; 
 Thu, 23 Nov 2023 09:07:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8Gi7MJsgwyp3zOo/2467aqc/M/daozAwh35KGnITuCCcQdz9+ORxm4RzBQ5/esGE3oypmmQ==
X-Received: by 2002:adf:ee8d:0:b0:32d:96a7:9551 with SMTP id
 b13-20020adfee8d000000b0032d96a79551mr48301wro.36.1700759224739; 
 Thu, 23 Nov 2023 09:07:04 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:dd6e:61bc:cc48:699f:b2ce])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a5d544c000000b0032db4e660d9sm2126540wrv.56.2023.11.23.09.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 09:07:04 -0800 (PST)
Date: Thu, 23 Nov 2023 12:06:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex Benn =?iso-8859-1?Q?=E9?= e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231123104336-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <4l0it.9kkxe9s135lg@linaro.org>
 <791c81ad-e98d-4eee-9ca7-f3157977913c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <791c81ad-e98d-4eee-9ca7-f3157977913c@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Thu, Nov 23, 2023 at 04:29:52PM +0100, Philippe Mathieu-Daudé wrote:
> This document targets all contributors. Contributions can be typo
> fix, translations, ... and don't have to be technical. Similarly,
> contributors aren't expected to be technical experts. As a neophyte,
> "AI" makes sense. "Idempotent code generator" or "LLM" don't :)

I don't think there's any big deal in using AI for typo fixes.

-- 
MST


