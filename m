Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC177F699E
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 00:56:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6JYS-0007XK-DD; Thu, 23 Nov 2023 18:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6JYQ-0007Wr-Bd
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 18:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6JYO-00018O-Un
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 18:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700783775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4cyLykNHHaaE5uZdJcFaDuWAkFG06U4hHH5fyylkjw=;
 b=FKXoVOf4bRJt6Eq/liIhKPBH8v2JMKONP6brogBAtkvxIOrR5wQd8EkGvZRBJaWLZuArsx
 xb1dJK05uNUAbOAxiipK/q4Fg/2bllEaNDm1RZv74n7TbiLh88cPTf79hUZSODQ5v+S8GA
 R2pmY/XS+MZ9VyT+lSbFZvkNY0d/tvI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-4f0ttsOyNN6OVXBtvapbMA-1; Thu, 23 Nov 2023 18:56:14 -0500
X-MC-Unique: 4f0ttsOyNN6OVXBtvapbMA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a01a0032b19so83644966b.2
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 15:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700783772; x=1701388572;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p4cyLykNHHaaE5uZdJcFaDuWAkFG06U4hHH5fyylkjw=;
 b=lNypw8YYscAicW8X3lHHNuBN5Az/iJ/PxyknlwfoQK5Qf7/8lgWUCjjL10HHtcdoJN
 +57kYP4s8VX5LDEObVaNLDuE3SiuwjhBWFa4ikf23S7oXk7p+7PGKgXzAUpmevTzTtxA
 UCPxXhk6eA3ndczFT1Iqj2Z0Z9sDciTaDPjuHk0Ta/wilG5n858/F70uUUhItidXKOyT
 4SG9WfH4QkZrjdtNR0o2/gyVBf32PkHe1kFx59MAiVPqKAJjpf1riv2X5xi8sd4lIUTB
 Pte6CwapqvGYKeKRp4W/5Gw/65Qehf9xR3680aX4Jprmh+Dg8yMNjx5R0mYPBUeJbEPJ
 G4Ng==
X-Gm-Message-State: AOJu0YxXWeopL0o/442ucdI61owbQma+vp11oMMIGWvM+Psmq3L3TblV
 CkvTxlOSl2ZCYB1OjCIpMSxfjwF9lQS2mWd+HInXGZBsBkXRYJC89QpwKKxf3Xj139K+FlvC9NW
 bjMKd4Hfr0dh0n2tHM0g+Yes=
X-Received: by 2002:a17:906:4c41:b0:a04:5301:2e8f with SMTP id
 d1-20020a1709064c4100b00a0453012e8fmr604216ejw.19.1700783771967; 
 Thu, 23 Nov 2023 15:56:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxJFvu9kJU+pHgr1Wc8E3BTQJFglZPeBJqJIsofOZQbgnoOckxjKsCY+gdoN2H4V32Jx7DCA==
X-Received: by 2002:a17:906:4c41:b0:a04:5301:2e8f with SMTP id
 d1-20020a1709064c4100b00a0453012e8fmr604202ejw.19.1700783771622; 
 Thu, 23 Nov 2023 15:56:11 -0800 (PST)
Received: from redhat.com ([2.55.10.128]) by smtp.gmail.com with ESMTPSA id
 dv23-20020a170906b81700b009fc6e3ef4e4sm1312364ejb.42.2023.11.23.15.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 15:56:11 -0800 (PST)
Date: Thu, 23 Nov 2023 18:56:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
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
Message-ID: <20231123185353-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <d3998e03-8f91-4bc3-896f-4a8f3174e442@linaro.org>
 <ZV-HHpLnjOj1LPDi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV-HHpLnjOj1LPDi@redhat.com>
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

On Thu, Nov 23, 2023 at 05:08:46PM +0000, Daniel P. Berrangé wrote:
> On Thu, Nov 23, 2023 at 12:58:18PM +0100, Philippe Mathieu-Daudé wrote:
> > On 23/11/23 12:40, Daniel P. Berrangé wrote:
> > > Currently we have a short paragraph saying that patches must include
> > > a Signed-off-by line, and merely link to the kernel documentation.
> > > The linked kernel docs have alot of content beyond the part about
> > > sign-off an thus is misleading/distracting to QEMU contributors.
> > > 
> > > This introduces a dedicated 'code-provenance' page in QEMU talking
> > > about why we require sign-off, explaining the other tags we commonly
> > > use, and what to do in some edge cases.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >   docs/devel/code-provenance.rst    | 197 ++++++++++++++++++++++++++++++
> > >   docs/devel/index-process.rst      |   1 +
> > >   docs/devel/submitting-a-patch.rst |  18 +--
> > >   3 files changed, 201 insertions(+), 15 deletions(-)
> > >   create mode 100644 docs/devel/code-provenance.rst
> 
> > > +Other commit tags
> > > +~~~~~~~~~~~~~~~~~
> > > +
> > > +While the ``Signed-off-by`` tag is mandatory, there are a number of
> > > +other tags that are commonly used during QEMU development
> > > +
> > > + * **``Reviewed-by``**: when a QEMU community member reviews a patch
> > > +   on the mailing list, if they consider the patch acceptable, they
> > > +   should send an email reply containing a ``Reviewed-by`` tag.
> > > +
> > > +   NB: a subsystem maintainer sending a pull request would replace
> > > +   their own ``Reviewed-by`` with another ``Signed-off-by``
> > 
> > Hmm not sure about replacing, they have different meaning. You can merge
> > patch you haven't reviewed. But as a maintainer you must S-o-b what you
> > end merging (what is mentioned below in "subsystem maintainer").
> 
> I've always taken it as implied that patches I queue are reviewed by me,

Well sometimes I queue patches not in my area that I have seen languish
on list with no replies for too long. I generally do a cursory review
but not to the level that I feel justifies Reviewed-by.


> but replies here suggest I'm in a minority on that.  That shows why it is
> worth documenting this for QEMU explicitly :-)

Absolutely.


