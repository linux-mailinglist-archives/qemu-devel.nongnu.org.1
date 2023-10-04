Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3962F7B7E71
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:46:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0J0-0002YZ-Br; Wed, 04 Oct 2023 07:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qo0Iw-0002Y4-4H
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qo0Iu-0002ol-M6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696419876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiSYiINJ6uJtsfq+/pK3ClNYYFDydaBPPc3U/qA2TUo=;
 b=IsOGuPL1muj11xzTsOewmTaEswEKuwcU5L2gPv24iH6h+elZxKP5IXW2QqpAxWcEg1qoMu
 QbuLRBmKZYWQIwQ8HpOEVMTTdQ1R7KdwMK7PDfDN0CNjps+Hbrb/VbCSkF2iltXe624swB
 nuGRqPhu4R+t+goKy+n92P++yqrWlzU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-lQ-wbkF9P_6tn0mKQ44Kng-1; Wed, 04 Oct 2023 07:44:28 -0400
X-MC-Unique: lQ-wbkF9P_6tn0mKQ44Kng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8F2628EA6E4;
 Wed,  4 Oct 2023 11:44:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6A4B40C2013;
 Wed,  4 Oct 2023 11:44:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B14021E6904; Wed,  4 Oct 2023 13:44:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/usb: Silence compiler warnings in USB code when
 compiling with -Wshadow
References: <20231004093620.97906-1-thuth@redhat.com>
Date: Wed, 04 Oct 2023 13:44:26 +0200
In-Reply-To: <20231004093620.97906-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 4 Oct 2023 11:36:20 +0200")
Message-ID: <8734yqfw85.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

I got one more:

../hw/usb/host-libusb.c: In function =E2=80=98usb_host_open=E2=80=99:
../hw/usb/host-libusb.c:1013:13: warning: declaration of =E2=80=98rc=E2=80=
=99 shadows a previous local [-Wshadow=3Dcompatible-local]
 1013 |         int rc =3D ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);
      |             ^~
../hw/usb/host-libusb.c:954:9: note: shadowed declaration is here
  954 |     int rc;
      |         ^~


