Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992DA47667
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Feb 2025 08:20:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnYBJ-0000Cd-Dq; Thu, 27 Feb 2025 02:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnYBH-0000C6-QH; Thu, 27 Feb 2025 02:19:39 -0500
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnYBE-0002eH-Ez; Thu, 27 Feb 2025 02:19:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BAC461142;
 Thu, 27 Feb 2025 07:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD6BC4CEDD;
 Thu, 27 Feb 2025 07:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740640773;
 bh=uTordXA6MaEuH41ZSrokwDn9YzrrXK3YvPjwk15VGEE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BrOS7tKFkZRzASt4b8/eCJhLAdguSzcQpduJsd61+sxwYKUchK7jsqEAdSVTSVgYu
 vKjxCD6tWLLT2DZlUxJvdDDQvjbCF0TWnNsUIteWhCrVNKfGxfUY4jnP8TI6GYbVZY
 R5yKx4nbOqPOf8ywzYUT50fPmYAFl8y3VflnckPuYlE6Z1ljYn63tSCUydeB7+ti44
 wOHmjpwqJ84+f0PtMu8EdY6fSV7VsMUHBd2M5OlTkFyoqRI9qog9G7N22LLb/nhskm
 /0l+eJDaO2bxGyONN8Sa4DzTojvXDYgLlqqmpGOXIn2YC/ND1PGHWzqw6HDvOZiGjT
 x1gGQHu5bwIew==
Date: Thu, 27 Feb 2025 08:19:27 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/14] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250227081927.726a1938@foz.lan>
In-Reply-To: <20250226165226.49b88429@imammedo.users.ipa.redhat.com>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <e9e0aafd7cc8613709171ec5d8a6d9d9be62d7c1.1740148260.git.mchehab+huawei@kernel.org>
 <20250226165226.49b88429@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04::f03c:95ff:fe5e:7468;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Wed, 26 Feb 2025 16:52:26 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 21 Feb 2025 15:35:17 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 

> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 5346cae573b7..14d8513a5440 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> >  
> >  static const Property acpi_ged_properties[] = {
> >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),  
> 
> you below set it for 9.2 to false, so
> shouldn't it be set to true by default here?

Yes, but it is too early to do that here, as the DSDT table was not
updated to contain the GED device.

We're switching it to true later on, at patch 11::

	d8c44ee13fbe ("arm/virt: Wire up a GED error device for ACPI / GHES")

Thanks,
Mauro

