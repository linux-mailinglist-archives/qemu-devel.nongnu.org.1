Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1FB7F72AF
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:28:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ULZ-0008Hf-PO; Fri, 24 Nov 2023 06:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6ULX-0008HF-KR
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:27:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6ULW-0005SE-21
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 06:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700825260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlCNjRHljiNpfHGH9oB1KH21li++v926JbeMqxVwhec=;
 b=b9908UCCr94hXNHGF2zZe1aG6rpK8th/dpj/umg95z4qFOj66ZJ/DhU4vWs3kvnInHhth+
 04x/EKo1t19EOx9vwSjOsFnz3UY9r4R3sC7AaBB3aVw6ZLDxwc6frQuKY/Iv4JaAuHJNYw
 6MBOu3sm/7u2VR3ilxCHQX9or2nMjXY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-Kg9AdDB2PACexvsinoxVTw-1; Fri, 24 Nov 2023 06:27:39 -0500
X-MC-Unique: Kg9AdDB2PACexvsinoxVTw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9fd114e21adso131242466b.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 03:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700825258; x=1701430058;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jlCNjRHljiNpfHGH9oB1KH21li++v926JbeMqxVwhec=;
 b=kaTFdPflnwwoGdygvhlZHCuOqRSZx2OaDmXARAxaNed6wLHS2Gp1XK8Oawyb3xw23X
 mjMPTImxbPCvi9AMp8fTU1ANYWV+LpBw0N9u+/T7ym27goBKFPy5sybg6e1gwGtaMKKH
 hj131I4DWY0uX+7a3s0zaMY8hGXeY3wUAbHnLm4VcRA4uPCpBEdahzYLgufhJlANw1to
 XU83jSThIdNMcRBycwszby8dKtnCcTiIddOsXs0jf/aQsD8tKV6fFz7leSlzMYVyXt5j
 kpFSeV8Wu5itBUke57+d23omHeaVHTD1uLI7Tf9Ou44GejEKPVH0PnTBMZoZMnK92sS8
 x1bA==
X-Gm-Message-State: AOJu0Yy3Et4+cXHHtQFDULv29wH4sj8Ks0nuO0eWLlGr1289uJcyBTfo
 wutKp80416wceBhiGejfrxEwXZ3yLICDOCY+pNdPzOG0rtnhkPccvmVC5Oy6aYS0r+fCZChM/Lb
 sZgyeLIa7Bj98Q+s=
X-Received: by 2002:a17:907:7203:b0:a01:9985:30d9 with SMTP id
 dr3-20020a170907720300b00a01998530d9mr1935686ejc.12.1700825258486; 
 Fri, 24 Nov 2023 03:27:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtv1xTyQ83OFXaRHh1tC6BZaWIb7ktJTXDsUyfAvmxCXAKYx7K20RjWQrah1ch34U9TGjmsA==
X-Received: by 2002:a17:907:7203:b0:a01:9985:30d9 with SMTP id
 dr3-20020a170907720300b00a01998530d9mr1935659ejc.12.1700825258025; 
 Fri, 24 Nov 2023 03:27:38 -0800 (PST)
Received: from redhat.com ([2.55.56.198]) by smtp.gmail.com with ESMTPSA id
 v12-20020a170906338c00b009f2b7282387sm1929980eja.46.2023.11.24.03.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 03:27:37 -0800 (PST)
Date: Fri, 24 Nov 2023 06:27:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <20231124062012-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <20231123091654-mutt-send-email-mst@kernel.org>
 <ZV-I_eWYsBeOe4Sp@redhat.com>
 <20231123123106-mutt-send-email-mst@kernel.org>
 <92246d2d-6d0e-416d-914b-08bb1fb0eac7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92246d2d-6d0e-416d-914b-08bb1fb0eac7@linaro.org>
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

On Fri, Nov 24, 2023 at 12:11:30PM +0100, Philippe Mathieu-Daudé wrote:
> On 23/11/23 18:33, Michael S. Tsirkin wrote:
> > On Thu, Nov 23, 2023 at 05:16:45PM +0000, Daniel P. Berrangé wrote:
> > > On Thu, Nov 23, 2023 at 09:25:13AM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Nov 23, 2023 at 11:40:25AM +0000, Daniel P. Berrangé wrote:
> > > > > Currently we have a short paragraph saying that patches must include
> > > > > a Signed-off-by line, and merely link to the kernel documentation.
> > > > > The linked kernel docs have alot of content beyond the part about
> > > > > sign-off an thus is misleading/distracting to QEMU contributors.
> > > > > 
> > > > > This introduces a dedicated 'code-provenance' page in QEMU talking
> > > > > about why we require sign-off, explaining the other tags we commonly
> > > > > use, and what to do in some edge cases.
> > > > > 
> > > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > 
> > > 
> > > > > +  * The non-primary author's contributions were so trivial that
> > > > > +    they can be considered not subject to copyright. In this case
> > > > > +    the secondary authors need not include a ``Signed-off-by``.
> > > > > +
> > > > > +    This case most commonly applies where QEMU reviewers give short
> > > > > +    snippets of code as suggested fixes to a patch. The reviewers
> > > > > +    don't need to have their own ``Signed-off-by`` added unless
> > > > > +    their code suggestion was unusually large.
> > > > 
> > > > It is still a good policy to include attribution, e.g.
> > > > by adding a Suggested-by tag.
> > > 
> > > Will add this tag.
> 
> Thanks!
> 
> > > > > +Other commit tags
> > > > > +~~~~~~~~~~~~~~~~~
> 
> 
> > > > As long as we are here, let's document Fixes: and Cc: ?
> > > 
> > > The submitting-a-patch doc covers more general commit message information.
> > > I think this doc just ought to focus on tags that identify humans involved
> > > in the process.
> > > 
> > > I've never been sure what the point of the 'Cc' tag is, when you actually
> > > want to use the Cc email header ?
> > > 
> > 
> > It records the fact that these people have been copied but did not
> > respond.
> This might be felt aggressive or forcing.
> My understanding of this Cc
> tag in a commit is "now that it is merged, you can't complain". We can
> be absent, sick, on holidays... If I missed a merged patch review I'll
> try to kindly ask on the list if it can be reworked, or suggest a patch
> to fix what I missed.

> Not sure this is really useful to commit that to the repository.

I don't see it as forcing. Sometimes I do a fly-by review of a patch
that caught my eye not in my area. Later people address my comments
and start copying me but I don't have time to re-review.
Recoding the fact that they copied me seems important.

This info might be helpful in git history for other reasons
- helps looking for someone to help review backports
- to guess at code quality - to help understand whether code had all the needed
  people copied


> 
> IMHO the only useful Cc tag is for qemu-stable@nongnu.org, as Kevin
> mentioned.
> 
> If you want to be sure your patch is Cc to a set of developers, you can
> add Cc: lines below the '---' patch separator. My 2 cents eh...
> 
> Regards,
> 
> Phil.


If people feel threatened by CC I don't have a problem to ask people
to put it in a note so it comes after ---.

-- 
MST


