Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CEE7FBC76
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:14:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yqg-0006ti-Jn; Tue, 28 Nov 2023 09:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r7yqe-0006rC-7I
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r7yqc-0007eh-F0
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701180837;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLV3cWE3WA+I4UFHToyaWA+DEpWbnsEkswW6PhnmcJc=;
 b=fzciLHewPQnpwii+UZ1nDixYT4Shd0fNx26r6ZRrBEomltwhPQVuiVy0el1HWUQjpQJP4f
 hQySfv5NOAHG+fAlYwS7TREbrGO2jgIGBzIEsDq5NdfaUi3tQuXZveeg1/m72HYSS2qds7
 lxDnW2uORJku+puzJjyhyE+bbDhWX2c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-Yui7kJNGPm2NWn-NIPpUBA-1; Tue,
 28 Nov 2023 09:13:56 -0500
X-MC-Unique: Yui7kJNGPm2NWn-NIPpUBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7AE4F2824772;
 Tue, 28 Nov 2023 14:13:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E33371C060AE;
 Tue, 28 Nov 2023 14:13:53 +0000 (UTC)
Date: Tue, 28 Nov 2023 14:13:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL 31/53] hw/i386/pc: Default to use SMBIOS 3.0 for newer
 machine models
Message-ID: <ZWX1n7OWh81Dd2tJ@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <59c230dab17176f798fb938ba4318543d9cf31d8.1687782442.git.mst@redhat.com>
 <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb7a62d4-886b-4887-94f7-c41659bfc6f6@proxmox.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

On Tue, Nov 28, 2023 at 02:57:17PM +0100, Fiona Ebner wrote:
> Am 26.06.23 um 14:29 schrieb Michael S. Tsirkin:
> > From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > 
> > Currently, pc-q35 and pc-i44fx machine models are default to use SMBIOS 2.8
> > (32-bit entry point). Since SMBIOS 3.0 (64-bit entry point) is now fully
> > supported since QEMU 7.0, default to use SMBIOS 3.0 for newer machine
> > models. This is necessary to avoid the following message when launching
> > a VM with large number of vcpus.
> > 
> >    "SMBIOS 2.1 table length 66822 exceeds 65535"
> > 
> > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > Message-Id: <20230607205717.737749-2-suravee.suthikulpanit@amd.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> Hi,
> 
> we received some reports about the new default causing issues for
> certain guest OSes [0][1]. Namely, for Juniper vSRX, where boot fails
> and Microsoft Windows, where querying an UUID set via QEMU cmdline
> -smbios 'type=1,uuid=a4656bd0-a07d-48e0-9dfd-bdc84667a8d0'
> in Powershell with
> get-wmiobject win32_computersystemproduct | Select-Object
> -expandProperty UUID
> doesn't return any value anymore and can trip up some guest
> applications. The original report is about Windows 10 and I reproduced
> this with Windows Server 2019 and the German (but I hope it doesn't
> matter this time) version of Windows Server 2022.
> 
> Using machine type 8.0 or the machine option smbios-entry-point-type=32
> are workarounds.
> 
> Since Windows is widely used, that seems a bit unfortunate. Just wanted
> to ask if you are aware of the issue and if there is something else that
> can be done other than specifying the more specific machine commandline
> for those OSes?

I don't recall seeing this issue mentioned before. Could you file a
bug at https://gitlab.com/qemu-project/qemu

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


