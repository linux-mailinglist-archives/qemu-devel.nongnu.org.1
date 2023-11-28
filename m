Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E687FBEF5
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 17:07:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80ay-0003dy-TI; Tue, 28 Nov 2023 11:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r80ag-0003dN-TP
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:05:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r80ae-0001xa-Eu
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 11:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701187535;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2//8FpN6nWpz7CW2ZJ14jrbMVqwd+JA9w3eTF6VnNsQ=;
 b=FDrLGPbWrpkJ6g5/Fcyw/bsP4lpYiSsP6nILuIYhbA1GYsa/LiD3P7FOfkuojGUWImakFk
 BrcxfR2KOkZUut1L+vvpkuP+SViGapXYWFgPsATZ8/nMY+7LQjfUp+503QvveSUbTFjLc4
 8IShha0U+ch4SNrF6DKzmZwXgHqe9ic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-nKA6Ib9sPJm9PoCPkh_Ndg-1; Tue, 28 Nov 2023 11:05:29 -0500
X-MC-Unique: nKA6Ib9sPJm9PoCPkh_Ndg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EC5985CBDA;
 Tue, 28 Nov 2023 16:04:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9483720268D8;
 Tue, 28 Nov 2023 16:04:54 +0000 (UTC)
Date: Tue, 28 Nov 2023 16:04:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL 31/53] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <ZWYPpNo0F_b1iYKv@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
 <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
 <ZWX1n7OWh81Dd2tJ@redhat.com>
 <76e8060f-ad71-4aa7-a675-baa735c9c2f2@proxmox.com>
 <20231128105920-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128105920-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Nov 28, 2023 at 11:00:29AM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 28, 2023 at 03:53:21PM +0100, Fiona Ebner wrote:
> > Am 28.11.23 um 15:13 schrieb Daniel P. Berrangé:
> > > On Tue, Nov 28, 2023 at 02:57:17PM +0100, Fiona Ebner wrote:
> > >> we received some reports about the new default causing issues for
> > >> certain guest OSes [0][1]. Namely, for Juniper vSRX, where boot fails
> > >> and Microsoft Windows, where querying an UUID set via QEMU cmdline
> > >> -smbios 'type=1,uuid=a4656bd0-a07d-48e0-9dfd-bdc84667a8d0'
> > >> in Powershell with
> > >> get-wmiobject win32_computersystemproduct | Select-Object
> > >> -expandProperty UUID
> > >> doesn't return any value anymore and can trip up some guest
> > >> applications. The original report is about Windows 10 and I reproduced
> > >> this with Windows Server 2019 and the German (but I hope it doesn't
> > >> matter this time) version of Windows Server 2022.
> > >>
> > >> Using machine type 8.0 or the machine option smbios-entry-point-type=32
> > >> are workarounds.
> > >>
> > >> Since Windows is widely used, that seems a bit unfortunate. Just wanted
> > >> to ask if you are aware of the issue and if there is something else that
> > >> can be done other than specifying the more specific machine commandline
> > >> for those OSes?
> > > 
> > > I don't recall seeing this issue mentioned before. Could you file a
> > > bug at https://gitlab.com/qemu-project/qemu
> > > 
> > 
> > I made one for the Windows issue:
> > https://gitlab.com/qemu-project/qemu/-/issues/2008
> > 
> > It's not clear to me if this is a bug in QEMU or just a bug/limitation
> > of the guest OS when 64 bit entry is used by SMBIOS.
> > 
> > I didn't create one for vSRX, because I'm not using it myself and since
> > it's based on FreeBSD and FreeBSD 13.1 can boot just fine with both 32
> > and 64 bit entry, it might be an issue on their side.
> > 
> > Best Regards,
> > Fiona
> 
> I would be inclined to limit this to when we have too many VCPUs then.

IIRC, it wasn't merely number of vCPUs that was a problem - a number of
other aspects can also influence the SMBIOS table size.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


