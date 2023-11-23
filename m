Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E407F65F3
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:05:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6E51-0005Ko-QL; Thu, 23 Nov 2023 13:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6E50-0005KS-Ky
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6E4u-0006Bt-PI
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700762727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZCeVfosFn1C0AJe/X8yGTldekha8CA+1Pw4rp9hmYNk=;
 b=fKmlZkFzWyAGUW+uMILpT7tg3i+N9DXohT09AjEu1WBmmHIOeSTO6i+1tFNU4+aZqkr5u6
 olWUgXNnBjJ3uUg1/3ENgwkmUHSG+4vQ1rXGhAsyB/P2kUXw8Sp44mcLgWiMRecDovolwj
 NOtD9yg1QjAbnLVTLrxQSMHQLVjGL1c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-Azw-nmhjO6uWGB7U-7heIQ-1; Thu, 23 Nov 2023 13:05:26 -0500
X-MC-Unique: Azw-nmhjO6uWGB7U-7heIQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40b297925ccso6195375e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700762725; x=1701367525;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCeVfosFn1C0AJe/X8yGTldekha8CA+1Pw4rp9hmYNk=;
 b=u8CaUzYbxdKeDk5nOwWVD6Idv0ZYLVGXqZNGT/QiF2F6joTqAYGIV0ui3QfTfsLW9O
 0A0tf1SezXQ+OBqxgn2q3rpMxexP+ZQGNTXd2pXtKpFZhr08xvOZQyuK0yK4LNl8/Qz6
 XCGlW3HjeWIV8X1QcqLyC/wCBosG4syThtxlr0Ons9xUaxbAyo1r4tKI3wUSavbWvQqK
 SJGNLuATA1T3tIubBHUGIvj40gM2giXV1418EXEF0YErXWI/QmwPvoNyK0Uuqd4EIZce
 PsidfYmmhY/9HGb7uz6TRizJbOKb8WWnCUAuYhPkSUvjTQlSTecLAw4zu93ttVbASCg4
 I1Sg==
X-Gm-Message-State: AOJu0YzAzJkL63l60lAfLnOr9qr9P8XxKgZVfSIO2zni5QTWyS5PeB5z
 wyU0Waq8vr9ul8X0d5jq+wKqR7Eti8v10hH4PRycezJavOCgxcB1vSVZ6y4Ou6mu4lJeUtfBC4f
 re/+8gVWiOZKEPO4=
X-Received: by 2002:a05:600c:1d0a:b0:409:79df:7f9c with SMTP id
 l10-20020a05600c1d0a00b0040979df7f9cmr257498wms.36.1700762725207; 
 Thu, 23 Nov 2023 10:05:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGL/LlmPwd/DBEFn9qZOprKvjHw2yStog1psrprrTeKY8jwk4PTVXB605ILs/twrPKnU3P6Q==
X-Received: by 2002:a05:600c:1d0a:b0:409:79df:7f9c with SMTP id
 l10-20020a05600c1d0a00b0040979df7f9cmr257467wms.36.1700762724798; 
 Thu, 23 Nov 2023 10:05:24 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:dd6e:61bc:cc48:699f:b2ce])
 by smtp.gmail.com with ESMTPSA id
 t17-20020a05600c451100b0040b379e8526sm1969553wmo.25.2023.11.23.10.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 10:05:24 -0800 (PST)
Date: Thu, 23 Nov 2023 13:05:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
Message-ID: <20231123124234-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <4l0it.9kkxe9s135lg@linaro.org>
 <791c81ad-e98d-4eee-9ca7-f3157977913c@linaro.org>
 <20231123104336-mutt-send-email-mst@kernel.org>
 <20231123172938.GU9696@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123172938.GU9696@kitsune.suse.cz>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 23, 2023 at 06:29:38PM +0100, Michal Suchánek wrote:
> On Thu, Nov 23, 2023 at 12:06:59PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Nov 23, 2023 at 04:29:52PM +0100, Philippe Mathieu-Daudé wrote:
> > > This document targets all contributors. Contributions can be typo
> > > fix, translations, ... and don't have to be technical. Similarly,
> > > contributors aren't expected to be technical experts. As a neophyte,
> > > "AI" makes sense. "Idempotent code generator" or "LLM" don't :)
> > 
> > I don't think there's any big deal in using AI for typo fixes.
> 
> For how many typos it is still OK, and would not a deterministic
> spellchecker be preferred?
> 
> There are some edge cases where using AI is OK, the problem is most of
> the time it is not clear it is OK to use.
> 
> Thanks
> 
> Michal

¯\_(ツ)_/¯ I am not a lawyer, and I don't speak for Red Hat.


My point is however that e.g. even if you are using e.g. a grammar
corrector you better make sure that it is not claiming that its output
is a derivative work.

-- 
MST


