Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5518B1FCB
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Apr 2024 13:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwsL-0007z6-Ik; Thu, 25 Apr 2024 07:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzws4-0007rD-L1
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:32 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwry-0008Ce-Mo
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:02:32 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41b51ee24f9so2079645e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042945; x=1714647745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bWeBXj+Rcq1Ig4OiKi3ZYcboAcFHPofG2jdDBnd1oA=;
 b=xEw86AMvlTBI45QwaA88bFzsSXzgIU0/kRewvIUfr7aNKK7auG80Ghns65spgpLi1z
 bnDYNf9WM5ewD2NF8gxQA7NUJL7eBHfgtoNJrBAX8aKp6975f1rT3vgXrVLmHhJNoLtZ
 n3iOPVC5QUxSE9esAXR0ha1QhwYCTEwkPNzVW9bbBi8KdMGcBqis+Aedo4ZT7he7/TqB
 FIlkRj1WGG9fChyzrERBVAMeXFZcskWLKaplBscenUhSrBGalEaefQcUBIyoSzxQHOQL
 0bKfEe6G1/mYw9dHeAhymrH7i44e0soEgpfW7FDGeNFV3SlkSyJS0RKAH2dD2ep/d+Je
 i2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042945; x=1714647745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bWeBXj+Rcq1Ig4OiKi3ZYcboAcFHPofG2jdDBnd1oA=;
 b=kpO5AbLYQZzy6bg1z7H97mHbhCYpT2IseuJ8/RLesU2dWNRh5+O3ZYA5SeSgMSyfqS
 tY/NZJGFPtNP7mOND3XCABWQK0mVvi+TiM9SRPWhc3py3YOvTYTC4pJeJPDZYvm7U1rG
 DmQpKb+WVO8rMtYs3dkVGAaKH5Q4SCE+Xfb1Xl0JovnOz2QrJdi5ENDreVYeXXG1nRv9
 BxkMTXTSxZp4SsOXPrmti4z5PVdjsvdvdlJ/QQFLrdVhe6ehc1Cezlp9mks12W1YA6CB
 oN+/o+DdmGBquGN1v/8UrJSplFsJjy0AUPd5vNTRkkdu2GnH/6apTO4R1RFOCwdjFuUb
 IpZw==
X-Gm-Message-State: AOJu0YyrSIXpWTyX+/qO/QmwsxlN1Y7ciN0Zr7xfF5v1B/Sdi8qWxLIv
 1ocWWFLqnWV5C3aBQQGx+yy85B5S0jscc152l/PXOMmLwS73QNN6bsG7RGfWEJXUqzEDE94Mlc3
 k
X-Google-Smtp-Source: AGHT+IEUMYXRqiLIWFxxroPfzW46L2BAQ+t0dFyu9IXEw/UtsPz1ZgY9ZMFFqavmpayk845iwOWhQw==
X-Received: by 2002:a05:600c:4fc4:b0:418:98fc:a46a with SMTP id
 o4-20020a05600c4fc400b0041898fca46amr2040794wmq.15.1714042944275; 
 Thu, 25 Apr 2024 04:02:24 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 z9-20020a05600c0a0900b00418916f5848sm26698328wmp.43.2024.04.25.04.02.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:02:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 04/22] scripts: add script to compare compatibility properties
Date: Thu, 25 Apr 2024 13:01:37 +0200
Message-ID: <20240425110157.20328-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Maksim Davydov <davydov-max@yandex-team.ru>

This script runs QEMU to obtain compat_props of machines and default
values of different types of drivers to produce comparison table. This
table can be used to compare machine types to choose the most suitable
machine or compare binaries to be sure that migration to the newer version
will save all device properties. Also the json or csv format of this
table can be used to check does a new machine affect the previous ones by
comparing tables with and without the new machine.

Default values (that will be used without machine compat_props) of
properties are needed to fill "holes" in the table (one machine has
the property but another machine not. For instance, 2.12 machine has
`{ "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" }`, but compat_pros of
3.1 machine doesn't have it. Thus, to compare these machines we need to
get unknown value of "EPYC-x86_64-cpu-xlevel" for 3.1 machine. These
unknown values in the table are called "holes". To get values for these
"holes" the script uses list of appropriate methods.)

Notes:
* Some init values from the devices can't be available like properties
  from virtio-9p when configure has --disable-virtfs. This situations will
  be seen in the table as "unavailable driver".
* Default values can be obtained in an unobvious way, like x86 features.
  If the script doesn't know how to get property default value to compare
  one machine with another it fills "holes" with "unavailable method". This
  is done because script uses whitelist model to get default values of
  different types. It means that the method that can't be applied to a new
  type that can crash this script. It is better to get an "unavailable
  driver" when creating a new machine with new compatible properties than
  to break this script. So it turns out a more stable and generic script.
* If the default value can't be obtained because this property doesn't
  exist or because this property can't have default value, appropriate
  "hole" will be filled by "unknown property" or "no default value"
* If the property is applied to the abstract class, the script collects
  default values from all child classes and prints all these classes
* Raw table (--raw flag) should be used with json/csv parameters for
  scripts and etc. Human-readable (default) format contains transformed
  and simplified values and it doesn't contain lines with the same values
  in columns

Example:
./scripts/compare-machine-types.py --mt pc-q35-6.2 pc-q35-7.1
╒══════════════════╤══════════════════════════╤════════════════════════════╤════════════════════════════╕
│      Driver      │         Property         │  build/qemu-system-x86_64  │  build/qemu-system-x86_64  │
│                  │                          │         pc-q35-6.2         │         pc-q35-7.1         │
╞══════════════════╪══════════════════════════╪════════════════════════════╪════════════════════════════╡
│     PIIX4_PM     │ x-not-migrate-acpi-index │            True            │           False            │
├──────────────────┼──────────────────────────┼────────────────────────────┼────────────────────────────┤
│ arm-gicv3-common │     force-8-bit-prio     │            True            │     unavailable driver     │
├──────────────────┼──────────────────────────┼────────────────────────────┼────────────────────────────┤
│     nvme-ns      │      eui64-default       │            True            │           False            │
├──────────────────┼──────────────────────────┼────────────────────────────┼────────────────────────────┤
│    virtio-mem    │  unplugged-inaccessible  │           False            │            auto            │
╘══════════════════╧══════════════════════════╧════════════════════════════╧════════════════════════════╛

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20240318213550.155573-5-davydov-max@yandex-team.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                      |   5 +
 scripts/compare-machine-types.py | 486 +++++++++++++++++++++++++++++++
 2 files changed, 491 insertions(+)
 create mode 100755 scripts/compare-machine-types.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 8bb32f4a7e..118206c3e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4229,3 +4229,8 @@ Code Coverage Tools
 M: Alex Bennée <alex.bennee@linaro.org>
 S: Odd Fixes
 F: scripts/coverage/
+
+Machine development tool
+M: Maksim Davydov <davydov-max@yandex-team.ru>
+S: Supported
+F: scripts/compare-machine-types.py
diff --git a/scripts/compare-machine-types.py b/scripts/compare-machine-types.py
new file mode 100755
index 0000000000..2af3995eb8
--- /dev/null
+++ b/scripts/compare-machine-types.py
@@ -0,0 +1,486 @@
+#!/usr/bin/env python3
+#
+# Script to compare machine type compatible properties (include/hw/boards.h).
+# compat_props are applied to the driver during initialization to change
+# default values, for instance, to maintain compatibility.
+# This script constructs table with machines and values of their compat_props
+# to compare and to find places for improvements or places with bugs. If
+# during the comparison, some machine type doesn't have a property (it is in
+# the comparison table because another machine type has it), then the
+# appropriate method will be used to obtain the default value of this driver
+# property via qmp command (e.g. query-cpu-model-expansion for x86_64-cpu).
+# These methods are defined below in qemu_property_methods.
+#
+# Copyright (c) Yandex Technologies LLC, 2023
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+
+import sys
+from os import path
+from argparse import ArgumentParser, RawTextHelpFormatter, Namespace
+import pandas as pd
+from contextlib import ExitStack
+from typing import Optional, List, Dict, Generator, Tuple, Union, Any, Set
+
+try:
+    qemu_dir = path.abspath(path.dirname(path.dirname(__file__)))
+    sys.path.append(path.join(qemu_dir, 'python'))
+    from qemu.machine import QEMUMachine
+except ModuleNotFoundError as exc:
+    print(f"Module '{exc.name}' not found.")
+    print("Try export PYTHONPATH=top-qemu-dir/python or run from top-qemu-dir")
+    sys.exit(1)
+
+
+default_qemu_args = '-enable-kvm -machine none'
+default_qemu_binary = 'build/qemu-system-x86_64'
+
+
+# Methods for gettig the right values of drivers properties
+#
+# Use these methods as a 'whitelist' and add entries only if necessary. It's
+# important to be stable and predictable in analysis and tests.
+# Be careful:
+# * Class must be inherited from 'QEMUObject' and used in new_driver()
+# * Class has to implement get_prop method in order to get values
+# * Specialization always wins (with the given classes for 'device' and
+#   'x86_64-cpu', method of 'x86_64-cpu' will be used for '486-x86_64-cpu')
+
+class Driver():
+    def __init__(self, vm: QEMUMachine, name: str, abstract: bool) -> None:
+        self.vm = vm
+        self.name = name
+        self.abstract = abstract
+        self.parent: Optional[Driver] = None
+        self.property_getter: Optional[Driver] = None
+
+    def get_prop(self, driver: str, prop: str) -> str:
+        if self.property_getter:
+            return self.property_getter.get_prop(driver, prop)
+        else:
+            return 'Unavailable method'
+
+    def is_child_of(self, parent: 'Driver') -> bool:
+        """Checks whether self is (recursive) child of @parent"""
+        cur_parent = self.parent
+        while cur_parent:
+            if cur_parent is parent:
+                return True
+            cur_parent = cur_parent.parent
+
+        return False
+
+    def set_implementations(self, implementations: List['Driver']) -> None:
+        self.implementations = implementations
+
+
+class QEMUObject(Driver):
+    def __init__(self, vm: QEMUMachine, name: str) -> None:
+        super().__init__(vm, name, True)
+
+    def set_implementations(self, implementations: List[Driver]) -> None:
+        self.implementations = implementations
+
+        # each implementation of the abstract driver has to use property getter
+        # of this abstract driver unless it has specialization. (e.g. having
+        # 'device' and 'x86_64-cpu', property getter of 'x86_64-cpu' will be
+        # used for '486-x86_64-cpu')
+        for impl in implementations:
+            if not impl.property_getter or\
+                    self.is_child_of(impl.property_getter):
+                impl.property_getter = self
+
+
+class QEMUDevice(QEMUObject):
+    def __init__(self, vm: QEMUMachine) -> None:
+        super().__init__(vm, 'device')
+        self.cached: Dict[str, List[Dict[str, Any]]] = {}
+
+    def get_prop(self, driver: str, prop_name: str) -> str:
+        if driver not in self.cached:
+            self.cached[driver] = self.vm.cmd('device-list-properties',
+                                              typename=driver)
+        for prop in self.cached[driver]:
+            if prop['name'] == prop_name:
+                return str(prop.get('default-value', 'No default value'))
+
+        return 'Unknown property'
+
+
+class QEMUx86CPU(QEMUObject):
+    def __init__(self, vm: QEMUMachine) -> None:
+        super().__init__(vm, 'x86_64-cpu')
+        self.cached: Dict[str, Dict[str, Any]] = {}
+
+    def get_prop(self, driver: str, prop_name: str) -> str:
+        if not driver.endswith('-x86_64-cpu'):
+            return 'Wrong x86_64-cpu name'
+
+        # crop last 11 chars '-x86_64-cpu'
+        name = driver[:-11]
+        if name not in self.cached:
+            self.cached[name] = self.vm.cmd(
+                'query-cpu-model-expansion', type='full',
+                model={'name': name})['model']['props']
+        return str(self.cached[name].get(prop_name, 'Unknown property'))
+
+
+# Now it's stub, because all memory_backend types don't have default values
+# but this behaviour can be changed
+class QEMUMemoryBackend(QEMUObject):
+    def __init__(self, vm: QEMUMachine) -> None:
+        super().__init__(vm, 'memory-backend')
+        self.cached: Dict[str, List[Dict[str, Any]]] = {}
+
+    def get_prop(self, driver: str, prop_name: str) -> str:
+        if driver not in self.cached:
+            self.cached[driver] = self.vm.cmd('qom-list-properties',
+                                              typename=driver)
+        for prop in self.cached[driver]:
+            if prop['name'] == prop_name:
+                return str(prop.get('default-value', 'No default value'))
+
+        return 'Unknown property'
+
+
+def new_driver(vm: QEMUMachine, name: str, is_abstr: bool) -> Driver:
+    if name == 'object':
+        return QEMUObject(vm, 'object')
+    elif name == 'device':
+        return QEMUDevice(vm)
+    elif name == 'x86_64-cpu':
+        return QEMUx86CPU(vm)
+    elif name == 'memory-backend':
+        return QEMUMemoryBackend(vm)
+    else:
+        return Driver(vm, name, is_abstr)
+# End of methods definition
+
+
+class VMPropertyGetter:
+    """It implements the relationship between drivers and how to get their
+    properties"""
+    def __init__(self, vm: QEMUMachine) -> None:
+        self.drivers: Dict[str, Driver] = {}
+
+        qom_all_types = vm.cmd('qom-list-types', abstract=True)
+        self.drivers = {t['name']: new_driver(vm, t['name'],
+                                              t.get('abstract', False))
+                        for t in qom_all_types}
+
+        for t in qom_all_types:
+            drv = self.drivers[t['name']]
+            if 'parent' in t:
+                drv.parent = self.drivers[t['parent']]
+
+        for drv in self.drivers.values():
+            imps = vm.cmd('qom-list-types', implements=drv.name)
+            # only implementations inherit property getter
+            drv.set_implementations([self.drivers[imp['name']]
+                                     for imp in imps])
+
+    def get_prop(self, driver: str, prop: str) -> str:
+        # wrong driver name or disabled in config driver
+        try:
+            drv = self.drivers[driver]
+        except KeyError:
+            return 'Unavailable driver'
+
+        assert not drv.abstract
+
+        return drv.get_prop(driver, prop)
+
+    def get_implementations(self, driver: str) -> List[str]:
+        return [impl.name for impl in self.drivers[driver].implementations]
+
+
+class Machine:
+    """A short QEMU machine type description. It contains only processed
+    compat_props (properties of abstract classes are applied to its
+    implementations)
+    """
+    # raw_mt_dict - dict produced by `query-machines`
+    def __init__(self, raw_mt_dict: Dict[str, Any],
+                 qemu_drivers: VMPropertyGetter) -> None:
+        self.name = raw_mt_dict['name']
+        self.compat_props: Dict[str, Any] = {}
+        # properties are applied sequentially and can rewrite values like in
+        # QEMU. Also it has to resolve class relationships to apply appropriate
+        # values from abstract class to all implementations
+        for prop in raw_mt_dict['compat-props']:
+            driver = prop['qom-type']
+            try:
+                # implementation adds only itself, abstract class adds
+                #  lementation (abstract classes are uninterestiong)
+                impls = qemu_drivers.get_implementations(driver)
+                for impl in impls:
+                    if impl not in self.compat_props:
+                        self.compat_props[impl] = {}
+                    self.compat_props[impl][prop['property']] = prop['value']
+            except KeyError:
+                # QEMU doesn't know this driver thus it has to be saved
+                if driver not in self.compat_props:
+                    self.compat_props[driver] = {}
+                self.compat_props[driver][prop['property']] = prop['value']
+
+
+class Configuration():
+    """Class contains all necessary components to generate table and is used
+    to compare different binaries"""
+    def __init__(self, vm: QEMUMachine,
+                 req_mt: List[str], all_mt: bool) -> None:
+        self._vm = vm
+        self._binary = vm.binary
+        self._qemu_args = args.qemu_args.split(' ')
+
+        self._qemu_drivers = VMPropertyGetter(vm)
+        self.req_mt = get_req_mt(self._qemu_drivers, vm, req_mt, all_mt)
+
+    def get_implementations(self, driver_name: str) -> List[str]:
+        return self._qemu_drivers.get_implementations(driver_name)
+
+    def get_table(self, req_props: List[Tuple[str, str]]) -> pd.DataFrame:
+        table: List[pd.DataFrame] = []
+        for mt in self.req_mt:
+            name = f'{self._binary}\n{mt.name}'
+            column = []
+            for driver, prop in req_props:
+                try:
+                    # values from QEMU machine type definitions
+                    column.append(mt.compat_props[driver][prop])
+                except KeyError:
+                    # values from QEMU type definitions
+                    column.append(self._qemu_drivers.get_prop(driver, prop))
+            table.append(pd.DataFrame({name: column}))
+
+        return pd.concat(table, axis=1)
+
+
+script_desc = """Script to compare machine types (their compat_props).
+
+Examples:
+* save info about all machines:  ./scripts/compare-machine-types.py --all \
+--format csv --raw > table.csv
+* compare machines: ./scripts/compare-machine-types.py --mt pc-q35-2.12 \
+pc-q35-3.0
+* compare binaries and machines: ./scripts/compare-machine-types.py \
+--mt pc-q35-6.2 pc-q35-7.0 --qemu-binary build/qemu-system-x86_64 \
+build/qemu-exp
+  ╒════════════╤══════════════════════════╤════════════════════════════\
+╤════════════════════════════╤══════════════════╤══════════════════╕
+  │   Driver   │         Property         │  build/qemu-system-x86_64  \
+│  build/qemu-system-x86_64  │  build/qemu-exp  │  build/qemu-exp  │
+  │            │                          │         pc-q35-6.2         \
+│         pc-q35-7.0         │    pc-q35-6.2    │    pc-q35-7.0    │
+  ╞════════════╪══════════════════════════╪════════════════════════════\
+╪════════════════════════════╪══════════════════╪══════════════════╡
+  │  PIIX4_PM  │ x-not-migrate-acpi-index │            True            \
+│           False            │      False       │      False       │
+  ├────────────┼──────────────────────────┼────────────────────────────\
+┼────────────────────────────┼──────────────────┼──────────────────┤
+  │ virtio-mem │  unplugged-inaccessible  │           False            \
+│            auto            │      False       │       auto       │
+  ╘════════════╧══════════════════════════╧════════════════════════════\
+╧════════════════════════════╧══════════════════╧══════════════════╛
+
+If a property from QEMU machine defintion applies to an abstract class (e.g. \
+x86_64-cpu) this script will compare all implementations of this class.
+
+"Unavailable method" - means that this script doesn't know how to get \
+default values of the driver. To add method use the construction described \
+at the top of the script.
+"Unavailable driver" - means that this script doesn't know this driver. \
+For instance, this can happen if you configure QEMU without this device or \
+if machine type definition has error.
+"No default value" - means that the appropriate method can't get the default \
+value and most likely that this property doesn't have it.
+"Unknown property" - means that the appropriate method can't find property \
+with this name."""
+
+
+def parse_args() -> Namespace:
+    parser = ArgumentParser(formatter_class=RawTextHelpFormatter,
+                            description=script_desc)
+    parser.add_argument('--format', choices=['human-readable', 'json', 'csv'],
+                        default='human-readable',
+                        help='returns table in json format')
+    parser.add_argument('--raw', action='store_true',
+                        help='prints ALL defined properties without value '
+                             'transformation. By default, only rows '
+                             'with different values will be printed and '
+                             'values will be transformed(e.g. "on" -> True)')
+    parser.add_argument('--qemu-args', default=default_qemu_args,
+                        help='command line to start qemu. '
+                             f'Default: "{default_qemu_args}"')
+    parser.add_argument('--qemu-binary', nargs="*", type=str,
+                        default=[default_qemu_binary],
+                        help='list of qemu binaries that will be compared. '
+                             f'Deafult: {default_qemu_binary}')
+
+    mt_args_group = parser.add_mutually_exclusive_group()
+    mt_args_group.add_argument('--all', action='store_true',
+                               help='prints all available machine types (list '
+                                    'of machine types will be ignored)')
+    mt_args_group.add_argument('--mt', nargs="*", type=str,
+                               help='list of Machine Types '
+                                    'that will be compared')
+
+    return parser.parse_args()
+
+
+def mt_comp(mt: Machine) -> Tuple[str, int, int, int]:
+    """Function to compare and sort machine by names.
+    It returns socket_name, major version, minor version, revision"""
+    # none, microvm, x-remote and etc.
+    if '-' not in mt.name or '.' not in mt.name:
+        return mt.name, 0, 0, 0
+
+    socket, ver = mt.name.rsplit('-', 1)
+    ver_list = list(map(int, ver.split('.', 2)))
+    ver_list += [0] * (3 - len(ver_list))
+    return socket, ver_list[0], ver_list[1], ver_list[2]
+
+
+def get_mt_definitions(qemu_drivers: VMPropertyGetter,
+                       vm: QEMUMachine) -> List[Machine]:
+    """Constructs list of machine definitions (primarily compat_props) via
+    info from QEMU"""
+    raw_mt_defs = vm.cmd('query-machines', compat_props=True)
+    mt_defs = []
+    for raw_mt in raw_mt_defs:
+        mt_defs.append(Machine(raw_mt, qemu_drivers))
+
+    mt_defs.sort(key=mt_comp)
+    return mt_defs
+
+
+def get_req_mt(qemu_drivers: VMPropertyGetter, vm: QEMUMachine,
+               req_mt: Optional[List[str]], all_mt: bool) -> List[Machine]:
+    """Returns list of requested by user machines"""
+    mt_defs = get_mt_definitions(qemu_drivers, vm)
+    if all_mt:
+        return mt_defs
+
+    if req_mt is None:
+        print('Enter machine types for comparision')
+        exit(0)
+
+    matched_mt = []
+    for mt in mt_defs:
+        if mt.name in req_mt:
+            matched_mt.append(mt)
+
+    return matched_mt
+
+
+def get_affected_props(configs: List[Configuration]) -> Generator[Tuple[str,
+                                                                        str],
+                                                                  None, None]:
+    """Helps to go through all affected in machine definitions drivers
+    and properties"""
+    driver_props: Dict[str, Set[Any]] = {}
+    for config in configs:
+        for mt in config.req_mt:
+            compat_props = mt.compat_props
+            for driver, prop in compat_props.items():
+                if driver not in driver_props:
+                    driver_props[driver] = set()
+                driver_props[driver].update(prop.keys())
+
+    for driver, props in sorted(driver_props.items()):
+        for prop in sorted(props):
+            yield driver, prop
+
+
+def transform_value(value: str) -> Union[str, bool]:
+    true_list = ['true', 'on']
+    false_list = ['false', 'off']
+
+    out = value.lower()
+
+    if out in true_list:
+        return True
+
+    if out in false_list:
+        return False
+
+    return value
+
+
+def simplify_table(table: pd.DataFrame) -> pd.DataFrame:
+    """transforms values to make it easier to compare it and drops rows
+    with the same values for all columns"""
+
+    table = table.map(transform_value)
+
+    return table[~table.iloc[:, 3:].eq(table.iloc[:, 2], axis=0).all(axis=1)]
+
+
+# constructs table in the format:
+#
+# Driver  | Property  | binary1  | binary1  | ...
+#         |           | machine1 | machine2 | ...
+# ------------------------------------------------------ ...
+# driver1 | property1 |  value1  |  value2  | ...
+# driver1 | property2 |  value3  |  value4  | ...
+# driver2 | property3 |  value5  |  value6  | ...
+#   ...   |    ...    |   ...    |   ...    | ...
+#
+def fill_prop_table(configs: List[Configuration],
+                    is_raw: bool) -> pd.DataFrame:
+    req_props = list(get_affected_props(configs))
+    if not req_props:
+        print('No drivers to compare. Check machine names')
+        exit(0)
+
+    driver_col, prop_col = tuple(zip(*req_props))
+    table = [pd.DataFrame({'Driver': driver_col}),
+             pd.DataFrame({'Property': prop_col})]
+
+    table.extend([config.get_table(req_props) for config in configs])
+
+    df_table = pd.concat(table, axis=1)
+
+    if is_raw:
+        return df_table
+
+    return simplify_table(df_table)
+
+
+def print_table(table: pd.DataFrame, table_format: str) -> None:
+    if table_format == 'json':
+        print(comp_table.to_json())
+    elif table_format == 'csv':
+        print(comp_table.to_csv())
+    else:
+        print(comp_table.to_markdown(index=False, stralign='center',
+                                     colalign=('center',), headers='keys',
+                                     tablefmt='fancy_grid',
+                                     disable_numparse=True))
+
+
+if __name__ == '__main__':
+    args = parse_args()
+    with ExitStack() as stack:
+        vms = [stack.enter_context(QEMUMachine(binary=binary, qmp_timer=15,
+               args=args.qemu_args.split(' '))) for binary in args.qemu_binary]
+
+        configurations = []
+        for vm in vms:
+            vm.launch()
+            configurations.append(Configuration(vm, args.mt, args.all))
+
+        comp_table = fill_prop_table(configurations, args.raw)
+        if not comp_table.empty:
+            print_table(comp_table, args.format)
-- 
2.41.0


