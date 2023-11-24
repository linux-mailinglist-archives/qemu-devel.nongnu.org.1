Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE587F72E4
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:39:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6UX9-0002eL-H5; Fri, 24 Nov 2023 06:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6UWx-0002Su-1G
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6UWr-0000B8-Ra
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700825964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P96SK9yoE+UvATGnmN+XB1RnbV/HqgBkqJAQkvf2vyI=;
 b=WyDsgCGPkLaeW1gSHOCDcPdD8RwiDVhhoxFOFZfm3AjrIue1o9vB5I13SqU7+ubrKs3Snw
 oDD8nh+lqecNGoSMiLjvtIPE4B/XMEiAsCu93NEnhTU6rJzG8CpY36CYnq9tz73YrUtX5d
 8Yt3Fn4ygAqOtTq08hy5g9dHAMHyh34=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-NwV8exuvOCmy7wOVqKn2iA-1; Fri, 24 Nov 2023 06:39:23 -0500
X-MC-Unique: NwV8exuvOCmy7wOVqKn2iA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a01c7b09335so133067366b.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700825962; x=1701430762;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P96SK9yoE+UvATGnmN+XB1RnbV/HqgBkqJAQkvf2vyI=;
 b=GE8F8QHUsW9OxY1J2/6zZoCMo0/hIbjaR5P5MDQM5XhsIuG+GBIVx41XFjtdDvrOG5
 9DbEGLvo4AllJWQ44OqRdJ4GcrKXbjP8rC490AsSwHEahfGqJNOT8vkI9Ozi29ul18Pm
 GvlrlgkAe6WfvTUqEJLD/bSpCSxGoE+Fh/43Ncyy6RjlJ8YN1BEhFvKCM5b7WfV282mI
 Ek+7zL31G3hSjdu5N3fxlE1zvp+Xnnbannzfrfvg1OZ12ta0ST/rNlTzQ33DAy25kXhN
 bXpR/CT0iwciNbpMowfVKN5h/lRkwl9ZAesmbOjANCMiHw8AUfFv2lKIFXJd+gMw6FID
 G5FA==
X-Gm-Message-State: AOJu0YwZeoKYW4B4Yrn5YOjJZVDn6hJNSf2w3CQUPvaPVrl6SK9Ny9fB
 sI/IiSVHKHS4z2KApHlFMaRDHRhLOBsQ/YoIc/GbR+mSrADrOg4ksDfJWk7/+AYhQ3ItYWKrIga
 pkJ6fjLafeK0tK+aVSSLyyCs=
X-Received: by 2002:a17:906:3496:b0:9fe:43a0:4ac0 with SMTP id
 g22-20020a170906349600b009fe43a04ac0mr1984915ejb.24.1700825961773; 
 Fri, 24 Nov 2023 03:39:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF99MZTZ6wwWIGwqYxEwNtjF8OwnkcfqW9ZNy/6v+09MZ6HrNMh+2MhEStq3eu4ZWfLf4+5Yw==
X-Received: by 2002:a17:906:3496:b0:9fe:43a0:4ac0 with SMTP id
 g22-20020a170906349600b009fe43a04ac0mr1984887ejb.24.1700825961467; 
 Fri, 24 Nov 2023 03:39:21 -0800 (PST)
Received: from redhat.com ([2.55.10.128]) by smtp.gmail.com with ESMTPSA id
 j8-20020a1709062a0800b00a0185ccedcasm1963020eje.223.2023.11.24.03.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 03:39:20 -0800 (PST)
Date: Fri, 24 Nov 2023 06:39:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231124063831-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org> <ZV-P6M8seKmMKGCB@redhat.com>
 <20231123183245-mutt-send-email-mst@kernel.org>
 <ZWB4MMrW1JttcxqI@redhat.com> <87edgfcueq.fsf@draig.linaro.org>
 <20231124053749-mutt-send-email-mst@kernel.org>
 <CAFEAcA-0Kusbm_YGo5xu7ztNxdMMe28U5+9Xp=Rp=UG+Ur6EFg@mail.gmail.com>
 <ZWCK67xSasXOhU0m@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWCK67xSasXOhU0m@redhat.com>
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

On Fri, Nov 24, 2023 at 11:37:15AM +0000, Daniel P. Berrangé wrote:
> On Fri, Nov 24, 2023 at 10:43:05AM +0000, Peter Maydell wrote:
> > On Fri, 24 Nov 2023 at 10:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Nov 24, 2023 at 10:33:49AM +0000, Alex Bennée wrote:
> > > > That probably means we can never use even open source LLMs to generate
> > > > code for QEMU because while the source data is all open source it won't
> > > > necessarily be GPL compatible.
> > >
> > > I would probably wait until the dust settles before we start accepting
> > > LLM generated code.
> > 
> > I think that's pretty much my take on what this policy is:
> > "say no for now; we can always come back later when the legal
> > situation seems clearer".
> 
> Yes, that was my thoughts exactly.
> 
> And if anyone comes along with a specific LLM/AI code generator that
> they believe can be used in a way compatible with the DCO, they can
> ask for an exception to the general policy which we can discuss then.

Yea. But why do you keep worrying about LLM/AI mess?  Are there code
generators whose output do allow? What are these?

-- 
MST


