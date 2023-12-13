Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A038115E5
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:14:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQwA-0006uv-79; Wed, 13 Dec 2023 10:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rDQw8-0006un-Aw
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rDQw1-0008Fn-Px
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702480444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ljnQfvRxxLocNeaf/7DTOOUFaN2zR/eiQNKFXZDBMZI=;
 b=I2y3/VY1WiizzV/zuY04Uz/jG1SaGNqkh9cHqr4U2GjH7Vzex5gGLFUFIvoAlwKHpB4a+f
 LQcGzcvCQ9IjNmyvq/QspQmtswKqkjHS0W2bOX2IaIYo6DsGJYy00hkG9Q5wPHgSU5HW+N
 i1XwHbX//h+an3Ul6LcYyJhpIXXUR+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-g8Y_1uflO_6k7Qo1csFLow-1; Wed, 13 Dec 2023 10:14:02 -0500
X-MC-Unique: g8Y_1uflO_6k7Qo1csFLow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D015185A787;
 Wed, 13 Dec 2023 15:14:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E9FD492BFA;
 Wed, 13 Dec 2023 15:14:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A69A91800990; Wed, 13 Dec 2023 16:14:00 +0100 (CET)
Date: Wed, 13 Dec 2023 16:14:00 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PULL 6/6] tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp
 changes
Message-ID: <dr77dip25isnjsfs3llxuxpxnym5dxwovwaruqvnjw5s6ydgou@7sni32qgde44>
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <20231213105026.1944656-7-kraxel@redhat.com>
 <AD96681F-FBF0-4AB9-8F2B-5B6C1FB5A52F@redhat.com>
 <20231213093242-mutt-send-email-mst@kernel.org>
 <98BBB08F-31A9-48B8-9DAF-CF32E1F8B742@redhat.com>
 <20231213100321-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213100321-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

  Hi,

> I agree, Gerd, going forward please include the diff of the
> disassemled AML.

That is in patch 5/6 which updates the test data.

take care,
  Gerd


