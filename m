Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEB6ADF322
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Jun 2025 18:55:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRw3K-0006FJ-3E; Wed, 18 Jun 2025 12:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRw3G-0006EW-Re
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 12:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRw3E-0007qp-0N
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 12:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750265653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QbRB5uWPGqfEm0xo5yH3n356L6Kq0CNI3IlCNKICTGI=;
 b=ZiRpS5Rhp+p5wy00gAD7u7YUII9HwJK8I6Sd86UK5uv/aagB5s2pOBsmfilmyZVu8VUAXt
 vqggXe5wJAh2Ksu6xkNeXlsv4lFbWXtJwZPn9WIvJwr3x4T+r8cEvUHTaBAShm152itBVY
 C+qbF1ITzEaQ0LLfiL2gQ0Zca1E0t6E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-les18dO-N1in7OeotnYSCg-1; Wed,
 18 Jun 2025 12:54:08 -0400
X-MC-Unique: les18dO-N1in7OeotnYSCg-1
X-Mimecast-MFC-AGG-ID: les18dO-N1in7OeotnYSCg_1750265645
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9DBF1800283; Wed, 18 Jun 2025 16:54:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.74])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C1BE30001B7; Wed, 18 Jun 2025 16:53:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Fan Ni <fan.ni@samsung.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fabiano Rosas <farosas@suse.de>, Kashyap Chamarthy <kchamart@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 0/5] docs: remove legacy qapidoc
Date: Wed, 18 Jun 2025 12:53:48 -0400
Message-ID: <20250618165353.1980365-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Remove docs/sphinx/qapidoc_legacy.py, and remove special parsing of=0D
freeform QAPI documentation block sections in favor of using standard=0D
rST syntax that is included in the final document with no special=0D
parsing or post-processing.=0D
=0D
v3:=0D
 - Fixed indentation for :error: in qapidoc=0D
 - Removed parser restrictions on QAPI-style headers=0D
 - Updated test output so make check passes ...=0D
=0D
v2:=0D
 - rebased on origin/master (2025-06-12)=0D
 - Revised commit messages with increased detail=0D
=0D
John Snow (5):=0D
  docs/sphinx: adjust qapidoc to cope with same-line error sections=0D
  docs/sphinx: parse @references in freeform text=0D
  docs/sphinx: remove legacy QAPI manual generator=0D
  docs/sphinx: remove special parsing for freeform sections=0D
  qapi: lift restriction on using '=3D' in doc blocks=0D
=0D
 docs/devel/qapi-code-gen.rst                 |  28 +-=0D
 docs/interop/firmware.json                   |   4 +-=0D
 docs/interop/qemu-ga-ref.rst                 |   1 -=0D
 docs/interop/qemu-qmp-ref.rst                |   1 -=0D
 docs/interop/qemu-storage-daemon-qmp-ref.rst |   1 -=0D
 docs/interop/vhost-user.json                 |   4 +-=0D
 docs/sphinx/qapidoc.py                       |  82 +---=0D
 docs/sphinx/qapidoc_legacy.py                | 440 -------------------=0D
 qapi/acpi.json                               |   4 +-=0D
 qapi/audio.json                              |   4 +-=0D
 qapi/authz.json                              |   4 +-=0D
 qapi/block-core.json                         |   3 +-=0D
 qapi/block-export.json                       |   3 +-=0D
 qapi/block.json                              |   7 +-=0D
 qapi/char.json                               |   4 +-=0D
 qapi/common.json                             |   4 +-=0D
 qapi/compat.json                             |   4 +-=0D
 qapi/control.json                            |   4 +-=0D
 qapi/crypto.json                             |   4 +-=0D
 qapi/cryptodev.json                          |   4 +-=0D
 qapi/cxl.json                                |   4 +-=0D
 qapi/dump.json                               |   4 +-=0D
 qapi/ebpf.json                               |   4 +-=0D
 qapi/error.json                              |   4 +-=0D
 qapi/introspect.json                         |   4 +-=0D
 qapi/job.json                                |   4 +-=0D
 qapi/machine-common.json                     |   4 +-=0D
 qapi/machine.json                            |   4 +-=0D
 qapi/migration.json                          |   4 +-=0D
 qapi/misc.json                               |   4 +-=0D
 qapi/net.json                                |   4 +-=0D
 qapi/pci.json                                |   4 +-=0D
 qapi/qapi-schema.json                        |   4 +-=0D
 qapi/qdev.json                               |   4 +-=0D
 qapi/qom.json                                |   4 +-=0D
 qapi/replay.json                             |   4 +-=0D
 qapi/rocker.json                             |   4 +-=0D
 qapi/run-state.json                          |   4 +-=0D
 qapi/sockets.json                            |   4 +-=0D
 qapi/stats.json                              |   4 +-=0D
 qapi/tpm.json                                |   4 +-=0D
 qapi/trace.json                              |   4 +-=0D
 qapi/transaction.json                        |   4 +-=0D
 qapi/uefi.json                               |   4 +-=0D
 qapi/ui.json                                 |  14 +-=0D
 qapi/vfio.json                               |   4 +-=0D
 qapi/virtio.json                             |   4 +-=0D
 qapi/yank.json                               |   4 +-=0D
 python/tests/qapi-isort.sh                   |   2 +-=0D
 scripts/qapi/parser.py                       |  11 -=0D
 storage-daemon/qapi/qapi-schema.json         |   8 +-=0D
 tests/qapi-schema/doc-bad-section.err        |   1 -=0D
 tests/qapi-schema/doc-bad-section.json       |  10 -=0D
 tests/qapi-schema/doc-bad-section.out        |   0=0D
 tests/qapi-schema/doc-good.json              |  10 +-=0D
 tests/qapi-schema/doc-good.out               |  10 +-=0D
 tests/qapi-schema/doc-good.txt               | 274 ++++--------=0D
 tests/qapi-schema/meson.build                |   1 -=0D
 58 files changed, 275 insertions(+), 784 deletions(-)=0D
 delete mode 100644 docs/sphinx/qapidoc_legacy.py=0D
 delete mode 100644 tests/qapi-schema/doc-bad-section.err=0D
 delete mode 100644 tests/qapi-schema/doc-bad-section.json=0D
 delete mode 100644 tests/qapi-schema/doc-bad-section.out=0D
=0D
-- =0D
2.48.1=0D
=0D


