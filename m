Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 664957F6275
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:14:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6BPO-0005fy-S6; Thu, 23 Nov 2023 10:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6BPJ-0005Yz-CK
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6BOx-0001Eq-95
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700752438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGmkdib5IvZVEQwLnkYLpoREfovQhtvZtmjYMP9CNpc=;
 b=EnyNRxptvuRT2B/YxQPC1WdcpFCD1Z+rPU0QtC8fCDIpFCNerah2/FLaU9Il9bqhnir04D
 xSYNawq4dJ4VEm84oIXxmCAybVrUNzpleCJJNWLPIfBs/YR5IgP5/nqJledtzvJlGYpeQG
 w87XwDBYAQQ+0cKfYMP79IGHy+RGxrc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-ea0FLQb1OdSgt4WFX-0x0Q-1; Thu, 23 Nov 2023 10:13:56 -0500
X-MC-Unique: ea0FLQb1OdSgt4WFX-0x0Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-407da05ee50so4896465e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700752435; x=1701357235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGmkdib5IvZVEQwLnkYLpoREfovQhtvZtmjYMP9CNpc=;
 b=pa1PGv6uaCIsXRW+j8Txc1oC3842RCPQkEmMb4gZA7zbx8pMlUIZWs/UzikhybVVWY
 yMdmnD5SYqFSgk5BDzIIagenoBATBkDcNrZc+KmUlaHN3OB9fcM8KhUrBTfAOn8vsFzg
 9F+e0jov5Nqc9sCexwz8B18Wt8LT4aqCtJdOPlPcC3YjdOzw8r3I3XuCnaA6tXZhIrCf
 dmk7ZGSDvALoXYa6tLCqHQo9QhmcXW6EQvSK56n3DsKpydNZpskxC6k1HdANuF8/GmQd
 KYqAOaYI3pCqaKEGtnAiaiJDSsCWsgTYHKkkAUycwefYFy8grr9GXFkjbiTuIDhJj9N9
 K13A==
X-Gm-Message-State: AOJu0Yz0BKAS9R1VVa7mdupVJLXTCFnv69g6evMtYHeMAgNl/KukhYHR
 sC+a5eFJoFFHVUvCqMkKAZ6eFyit6D/rBAgcRCNthsWQCIbevJeQXfSFGJ8hXmefH6PMDkPJ9Lv
 Kqz8kBNEJBkc49qU=
X-Received: by 2002:a05:6000:1569:b0:332:cfbc:cb56 with SMTP id
 9-20020a056000156900b00332cfbccb56mr4775966wrz.5.1700752435317; 
 Thu, 23 Nov 2023 07:13:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8vGo8tLoFo3D1MJhOppsxm/yRNec1W7CiL86DSCZgOIQsON7ebaetztEBerOCmJTCc7TbxA==
X-Received: by 2002:a05:6000:1569:b0:332:cfbc:cb56 with SMTP id
 9-20020a056000156900b00332cfbccb56mr4775955wrz.5.1700752434988; 
 Thu, 23 Nov 2023 07:13:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:dd6e:61bc:cc48:699f:b2ce])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a5d628f000000b0033134ab9691sm1904191wru.57.2023.11.23.07.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:13:54 -0800 (PST)
Date: Thu, 23 Nov 2023 10:13:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=  <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231123101309-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <4l0it.9kkxe9s135lg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4l0it.9kkxe9s135lg@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Nov 23, 2023 at 04:56:28PM +0200, Manos Pitsidianakis wrote:
> > However, can't we define a simpler more specific policy?
> > For example, isn't it true that *any* automatically generated code
> > can only be included if the scripts producing said code
> > are also included or otherwise available under GPLv2?
> 
> The following definition makes sense to me:
> 
> - Automated codegen tool must be idempotent.
> - Automated codegen tool must not use statistical modelling.

Why does it matter so much?

> I'd remove all AI or LLM references. These are non-specific, colloquial and
> in the case of `AI`, non-technical. This policy should apply the same to a
> Markov chain code generator.

-- 
MST


