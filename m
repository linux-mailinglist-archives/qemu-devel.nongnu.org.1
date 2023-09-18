Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E397A467D
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:00:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiB39-0006yd-SS; Mon, 18 Sep 2023 06:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiB31-0006uJ-Nc
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiB2z-0003av-Rh
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695031204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDhBwu15891KYlJmQpm+nP6OzqptpA7W2UUp1KAznSQ=;
 b=GUDuToZ7CUo0ELY9bdehtiQb2+UcZoU+zfTlNLp8a8goO5w0cZYtZMcvEx+aoSGURmOIQC
 YAbBVNdTpf1VKeHUG9faB5+tGdVFJ8aBfRfpA6iXqRwd43SZph65VFAKnzTigVKU0nxzdA
 wG1idFJD58xfmCahhPbpm3CTxobymTs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-qzdKCiSCPwGMkwW6lmcPdg-1; Mon, 18 Sep 2023 06:00:01 -0400
X-MC-Unique: qzdKCiSCPwGMkwW6lmcPdg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A1F7800888;
 Mon, 18 Sep 2023 10:00:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A22F4011E4;
 Mon, 18 Sep 2023 10:00:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CA56118007A1; Mon, 18 Sep 2023 11:59:59 +0200 (CEST)
Date: Mon, 18 Sep 2023 11:59:59 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/3] Firmware/seabios 20230912 patches
Message-ID: <d7zwpgvdosd7ron3odscmwfqq5cwibyqi2drkjv22z5m5nzn3r@ltokhlip4ztv>
References: <20230912105359.563101-1-kraxel@redhat.com>
 <CAJSP0QX23UNOTCRsiHZWSa1j9KGA229S84+k7nNiDyp-AkNCFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QX23UNOTCRsiHZWSa1j9KGA229S84+k7nNiDyp-AkNCFg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Hi Gerd,
> I think either this pull request or your edk2 pull request causes the
> following CI failure:
> 
> >>> G_TEST_DBUS_DAEMON=/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-aarch64 MALLOC_PERTURB_=199 /builds/qemu-project/qemu/build/tests/qtest/bios-tables-test --tap -k
> ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――

Address change in ACPI tables (edk2 PR):

     DefinitionBlock ("", "SSDT", 1, "BOCHS ", "NVDIMM", 0x00000001)
     {
         Scope (\_SB)
         {
             Device (NVDR)
             {
                 Name (_HID, "ACPI0012" /* NVDIMM Root Device */)  // _HID: Hardware ID
		 [ ... ]
             }
         }
    
    -    Name (MEMA, 0x43D10000)
    +    Name (MEMA, 0x43C90000)
     }

seabios PR is fine and passes "make check".

take care,
  Gerd


