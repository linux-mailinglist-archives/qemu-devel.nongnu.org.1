Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B09A39BB2
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Feb 2025 13:04:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkMK2-00006g-AN; Tue, 18 Feb 2025 07:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tkMJu-0008QJ-A7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:03:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1tkMJs-0003Ko-IN
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 07:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739880198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tl5jWt1jY+CS4reZsM+ZcrEsJGS2JjPTAKSIDHPZXuQ=;
 b=J51hxAXw/s9GW43Djcpg2ocPIINLRhB8RwIRFeOb3XLbZ36OcxuKGHNsvXA9H/H+GQ84aE
 PFGwFTCniVWTTiQihsRSwcc9A4RAhvQb4arxgiIIS4riGXYswT3jhda41i8OnBcMglGM6T
 Vk9rIZJHUmmhguhingYiB+fL4uTHEqA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-amhCjBS9M62iSJguWJGg7g-1; Tue,
 18 Feb 2025 07:03:15 -0500
X-MC-Unique: amhCjBS9M62iSJguWJGg7g-1
X-Mimecast-MFC-AGG-ID: amhCjBS9M62iSJguWJGg7g_1739880193
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76D121978C99; Tue, 18 Feb 2025 12:03:11 +0000 (UTC)
Received: from gezellig (unknown [10.44.34.39])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C63C19560A3; Tue, 18 Feb 2025 12:02:51 +0000 (UTC)
Date: Tue, 18 Feb 2025 17:32:47 +0530
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org,
 Ninad Palsule <ninad@linux.ibm.com>, sebott@redhat.com,
 maz@kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Yi Liu <yi.l.liu@intel.com>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 2/3] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
Message-ID: <Z7R259Pl1218TsOC@gezellig>
References: <20250217163732.3718617-1-kchamart@redhat.com>
 <20250217163732.3718617-3-kchamart@redhat.com>
 <ff481ffd-545f-4d0c-b53a-3cf9e0f8f388@redhat.com>
 <Z7Qnsm02w6gao_ui@gezellig>
 <CAFEAcA8H0P14JaAtpcwG99SYkqAdhoNzyQBuO++YjJjM1rUbPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8H0P14JaAtpcwG99SYkqAdhoNzyQBuO++YjJjM1rUbPw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 18, 2025 at 11:34:38AM +0000, Peter Maydell wrote:
> On Tue, 18 Feb 2025 at 11:29, Kashyap Chamarthy <kchamart@redhat.com> wrote:

[...]

> > > Maybe we shall
> > > - rename KVM vCPU Features -> KVM only vCPU Features
> > > - Add a TCG only vCPU features including both SME and RME ones
> > > - introduce a top level KVM and TCG vCPU features with below:
> > > PAUTH, SVE, detailing potential different semantic for both KVM and TCG mode
> >
> > Yeah, it can be done.  Would you be okay if I do it as a follow-up?  As
> > this a re-work of the entire doc with several features.
> 
> I think personally I would favour not having the split of
> "KVM only", "TCG only", etc sections. Instead document
> all of the properties in the same format, and have each
> property say whether it is TCG-specific, KVM-specific, etc.
> 
> Some of these properties may at some point in the future
> change, after all -- SME is currently TCG only but may get
> support in KVM and HVF in future; "aarch64" is currently
> KVM only but we might some day support it in TCG.

I agree.  As the PAuth case demonstrated, it only makes sense to
entirely do away with KVM- and TCG-specific sections and use a
consistent format througout.  That way, no need to remember to update
outdated sections.  It's also consistent with the x86 docs[1], where we
don't draw attention to KVM- or TCG-specific features.

I can rework the doc and send a follow-up.  (Eric: I assume you're also
fine with Peter's suggestion above :))

[1] https://www.qemu.org/docs/master/system/i386/cpu.html

-- 
/kashyap


