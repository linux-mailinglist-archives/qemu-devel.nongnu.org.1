Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0CC9052D3
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jun 2024 14:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNLk-0001N9-Ku; Wed, 12 Jun 2024 08:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNLL-0000uf-30; Wed, 12 Jun 2024 08:44:48 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sHNLG-00050C-FJ; Wed, 12 Jun 2024 08:44:46 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so4913863a34.3; 
 Wed, 12 Jun 2024 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718196280; x=1718801080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVSBOmohAArIMpH4mtyZCzrUQFN34V9UgfIvV71LsHE=;
 b=IImZkPhDKP6vUnq8JRArTE8I5m1v/LX9qMzvl3v6jyfgv7GKAtJTPK7+T1pRqFmAdv
 edT5MfGO0faXQZk30uoZtbfNL7NH+qLqx1H6eHco0loJiLr7M7zc6FttsHR+Cz3qj6Qo
 OzV0AFO2SdEZBZ26XFsAqR4Vwd9Ppc84FrnyqWqCwAOkzsvoeLHYeiXTgPSKztlt6QU0
 eC+E/Wd709990gskzjkOJg8Jp7M6IBE5jKtgUAWgXUoowIRukC8w0OMAASyVGU2JsS5B
 S4o3ILLFNcJgDAIbeJNfpePR0fGxaNRhG4xi57tnzOMnIke15ekJD3C0eqeV27pzh0N0
 LbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718196280; x=1718801080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVSBOmohAArIMpH4mtyZCzrUQFN34V9UgfIvV71LsHE=;
 b=hmJW1/Lrf+vk3URekrr4soXrGdR6ropsw3oVs+M3kYtgadQdbkf4+GT/3DQC0N1gct
 Fr6fTVZOl5Z+f0gg0kw5cTkW3y32z5w0cHiIBAGJtiIYr4qOdvF75FHEjwhf5faRQzE1
 WlSOIVdXk+F2yZ+D47kNyjTbf1MtQIBD1zJogeGk0KmGBuzwh2WO0aAccSYg1KEuFv9P
 sYCUgzrXbA1QB/RC9Lurlfa1RjNfk+zl0YyD7c0CbVpitTpWeM8UEDElQfZo6FkBldrp
 e/A0OgUZZlJNj0uxks+U3znTYUwI4iRnt/vOeKZOSQpD/2D7w1sYkvCvpN++kYExfUOO
 Vqkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdXAXas760hRPpCbILgkqIvT/G4jZ5w36YyL3U/GkRZKTyyjOvFif4SkgS+FVZjfcqTZwDClGRHy65yfN4zQq/12csPFY=
X-Gm-Message-State: AOJu0YwUiiWEdGFFqtMXeedZQnPoyGISNdcPFeCnOCFmsAVTnF6YkXoA
 gwWanSR3E73Kp2SjGEQTTfuVQXkqMvIB88eRfT3L5myTm/hMEXUkAI0gLnEgSuU=
X-Google-Smtp-Source: AGHT+IFz5uac5judAZ4iWn5htjOrQ1rl+XRLPoc0P7KXMLix9bcBnpH8W3dOUIClOMZ8R4rqVXn9Og==
X-Received: by 2002:a05:6871:3428:b0:24f:d9b2:b4a with SMTP id
 586e51a60fabf-25514c02ca0mr1965089fac.10.1718196279220; 
 Wed, 12 Jun 2024 05:44:39 -0700 (PDT)
Received: from amjad-pc.. ([202.185.212.207]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042dff35fdsm6928961b3a.131.2024.06.12.05.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 05:44:38 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v5 5/5] iotests: Add `vvfat` tests
Date: Wed, 12 Jun 2024 20:43:26 +0800
Message-ID: <0aa2f5704890e20e3dcb4f33ce68a8fb7393e2f2.1718195956.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1718195956.git.amjadsharafi10@gmail.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Added several tests to verify the implementation of the vvfat driver.

We needed a way to interact with it, so created a basic `fat16.py` driver
that handled writing correct sectors for us.

Added `vvfat` to the non-generic formats, as its not a normal image format.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 tests/qemu-iotests/check           |   2 +-
 tests/qemu-iotests/fat16.py        | 673 +++++++++++++++++++++++++++++
 tests/qemu-iotests/testenv.py      |   2 +-
 tests/qemu-iotests/tests/vvfat     | 457 ++++++++++++++++++++
 tests/qemu-iotests/tests/vvfat.out |   5 +
 5 files changed, 1137 insertions(+), 2 deletions(-)
 create mode 100644 tests/qemu-iotests/fat16.py
 create mode 100755 tests/qemu-iotests/tests/vvfat
 create mode 100755 tests/qemu-iotests/tests/vvfat.out

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 56d88ca423..545f9ec7bd 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -84,7 +84,7 @@ def make_argparser() -> argparse.ArgumentParser:
     p.set_defaults(imgfmt='raw', imgproto='file')
 
     format_list = ['raw', 'bochs', 'cloop', 'parallels', 'qcow', 'qcow2',
-                   'qed', 'vdi', 'vpc', 'vhdx', 'vmdk', 'luks', 'dmg']
+                   'qed', 'vdi', 'vpc', 'vhdx', 'vmdk', 'luks', 'dmg', 'vvfat']
     g_fmt = p.add_argument_group(
         '  image format options',
         'The following options set the IMGFMT environment variable. '
diff --git a/tests/qemu-iotests/fat16.py b/tests/qemu-iotests/fat16.py
new file mode 100644
index 0000000000..abe4ce1f8f
--- /dev/null
+++ b/tests/qemu-iotests/fat16.py
@@ -0,0 +1,673 @@
+# A simple FAT16 driver that is used to test the `vvfat` driver in QEMU.
+#
+# Copyright (C) 2024 Amjad Alsharafi <amjadsharafi10@gmail.com>
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
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+from typing import List
+import string
+
+SECTOR_SIZE = 512
+DIRENTRY_SIZE = 32
+ALLOWED_FILE_CHARS = set(
+    "!#$%&'()-@^_`{}~" + string.digits + string.ascii_uppercase
+)
+
+
+class MBR:
+    def __init__(self, data: bytes):
+        assert len(data) == 512
+        self.partition_table = []
+        for i in range(4):
+            partition = data[446 + i * 16 : 446 + (i + 1) * 16]
+            self.partition_table.append(
+                {
+                    "status": partition[0],
+                    "start_head": partition[1],
+                    "start_sector": partition[2] & 0x3F,
+                    "start_cylinder": ((partition[2] & 0xC0) << 2)
+                                      | partition[3],
+                    "type": partition[4],
+                    "end_head": partition[5],
+                    "end_sector": partition[6] & 0x3F,
+                    "end_cylinder": ((partition[6] & 0xC0) << 2) | partition[7],
+                    "start_lba": int.from_bytes(partition[8:12], "little"),
+                    "size": int.from_bytes(partition[12:16], "little"),
+                }
+            )
+
+    def __str__(self):
+        return "\n".join(
+            [
+                f"{i}: {partition}"
+                for i, partition in enumerate(self.partition_table)
+            ]
+        )
+
+
+class FatBootSector:
+    def __init__(self, data: bytes):
+        assert len(data) == 512
+        self.bytes_per_sector = int.from_bytes(data[11:13], "little")
+        self.sectors_per_cluster = data[13]
+        self.reserved_sectors = int.from_bytes(data[14:16], "little")
+        self.fat_count = data[16]
+        self.root_entries = int.from_bytes(data[17:19], "little")
+        total_sectors_16 = int.from_bytes(data[19:21], "little")
+        self.media_descriptor = data[21]
+        self.sectors_per_fat = int.from_bytes(data[22:24], "little")
+        self.sectors_per_track = int.from_bytes(data[24:26], "little")
+        self.heads = int.from_bytes(data[26:28], "little")
+        self.hidden_sectors = int.from_bytes(data[28:32], "little")
+        total_sectors_32 = int.from_bytes(data[32:36], "little")
+        assert (
+            total_sectors_16 == 0 or total_sectors_32 == 0
+        ), "Both total sectors (16 and 32) fields are non-zero"
+        self.total_sectors = total_sectors_16 or total_sectors_32
+        self.drive_number = data[36]
+        self.volume_id = int.from_bytes(data[39:43], "little")
+        self.volume_label = data[43:54].decode("ascii").strip()
+        self.fs_type = data[54:62].decode("ascii").strip()
+
+    def root_dir_start(self):
+        """
+        Calculate the start sector of the root directory.
+        """
+        return self.reserved_sectors + self.fat_count * self.sectors_per_fat
+
+    def root_dir_size(self):
+        """
+        Calculate the size of the root directory in sectors.
+        """
+        return (
+            self.root_entries * DIRENTRY_SIZE + self.bytes_per_sector - 1
+        ) // self.bytes_per_sector
+
+    def data_sector_start(self):
+        """
+        Calculate the start sector of the data region.
+        """
+        return self.root_dir_start() + self.root_dir_size()
+
+    def first_sector_of_cluster(self, cluster: int):
+        """
+        Calculate the first sector of the given cluster.
+        """
+        return (
+            self.data_sector_start() + (cluster - 2) * self.sectors_per_cluster
+        )
+
+    def cluster_bytes(self):
+        """
+        Calculate the number of bytes in a cluster.
+        """
+        return self.bytes_per_sector * self.sectors_per_cluster
+
+    def __str__(self):
+        return (
+            f"Bytes per sector: {self.bytes_per_sector}\n"
+            f"Sectors per cluster: {self.sectors_per_cluster}\n"
+            f"Reserved sectors: {self.reserved_sectors}\n"
+            f"FAT count: {self.fat_count}\n"
+            f"Root entries: {self.root_entries}\n"
+            f"Total sectors: {self.total_sectors}\n"
+            f"Media descriptor: {self.media_descriptor}\n"
+            f"Sectors per FAT: {self.sectors_per_fat}\n"
+            f"Sectors per track: {self.sectors_per_track}\n"
+            f"Heads: {self.heads}\n"
+            f"Hidden sectors: {self.hidden_sectors}\n"
+            f"Drive number: {self.drive_number}\n"
+            f"Volume ID: {self.volume_id}\n"
+            f"Volume label: {self.volume_label}\n"
+            f"FS type: {self.fs_type}\n"
+        )
+
+
+class FatDirectoryEntry:
+    def __init__(self, data: bytes, sector: int, offset: int):
+        self.name = data[0:8].decode("ascii").strip()
+        self.ext = data[8:11].decode("ascii").strip()
+        self.attributes = data[11]
+        self.reserved = data[12]
+        self.create_time_tenth = data[13]
+        self.create_time = int.from_bytes(data[14:16], "little")
+        self.create_date = int.from_bytes(data[16:18], "little")
+        self.last_access_date = int.from_bytes(data[18:20], "little")
+        high_cluster = int.from_bytes(data[20:22], "little")
+        self.last_mod_time = int.from_bytes(data[22:24], "little")
+        self.last_mod_date = int.from_bytes(data[24:26], "little")
+        low_cluster = int.from_bytes(data[26:28], "little")
+        self.cluster = (high_cluster << 16) | low_cluster
+        self.size_bytes = int.from_bytes(data[28:32], "little")
+
+        # extra (to help write back to disk)
+        self.sector = sector
+        self.offset = offset
+
+    def as_bytes(self) -> bytes:
+        return (
+            self.name.ljust(8, " ").encode("ascii")
+            + self.ext.ljust(3, " ").encode("ascii")
+            + self.attributes.to_bytes(1, "little")
+            + self.reserved.to_bytes(1, "little")
+            + self.create_time_tenth.to_bytes(1, "little")
+            + self.create_time.to_bytes(2, "little")
+            + self.create_date.to_bytes(2, "little")
+            + self.last_access_date.to_bytes(2, "little")
+            + (self.cluster >> 16).to_bytes(2, "little")
+            + self.last_mod_time.to_bytes(2, "little")
+            + self.last_mod_date.to_bytes(2, "little")
+            + (self.cluster & 0xFFFF).to_bytes(2, "little")
+            + self.size_bytes.to_bytes(4, "little")
+        )
+
+    def whole_name(self):
+        if self.ext:
+            return f"{self.name}.{self.ext}"
+        else:
+            return self.name
+
+    def __str__(self):
+        return (
+            f"Name: {self.name}\n"
+            f"Ext: {self.ext}\n"
+            f"Attributes: {self.attributes}\n"
+            f"Reserved: {self.reserved}\n"
+            f"Create time tenth: {self.create_time_tenth}\n"
+            f"Create time: {self.create_time}\n"
+            f"Create date: {self.create_date}\n"
+            f"Last access date: {self.last_access_date}\n"
+            f"Last mod time: {self.last_mod_time}\n"
+            f"Last mod date: {self.last_mod_date}\n"
+            f"Cluster: {self.cluster}\n"
+            f"Size: {self.size_bytes}\n"
+        )
+
+    def __repr__(self):
+        # convert to dict
+        return str(vars(self))
+
+
+class Fat16:
+    def __init__(
+        self,
+        start_sector: int,
+        size: int,
+        sector_reader: callable,
+        sector_writer: callable,
+    ):
+        self.start_sector = start_sector
+        self.size_in_sectors = size
+        self.sector_reader = sector_reader
+        self.sector_writer = sector_writer
+
+        self.boot_sector = FatBootSector(self.sector_reader(start_sector))
+
+        fat_size_in_sectors = (
+            self.boot_sector.sectors_per_fat * self.boot_sector.fat_count
+        )
+        self.fats = self.read_sectors(
+            self.boot_sector.reserved_sectors, fat_size_in_sectors
+        )
+        self.fats_dirty_sectors = set()
+
+    def read_sectors(self, start_sector: int, num_sectors: int) -> bytes:
+        return self.sector_reader(start_sector + self.start_sector, num_sectors)
+
+    def write_sectors(self, start_sector: int, data: bytes):
+        return self.sector_writer(start_sector + self.start_sector, data)
+
+    def directory_from_bytes(
+        self, data: bytes, start_sector: int
+    ) -> List[FatDirectoryEntry]:
+        """
+        Convert `bytes` into a list of `FatDirectoryEntry` objects.
+        Will ignore long file names.
+        Will stop when it encounters a 0x00 byte.
+        """
+
+        entries = []
+        for i in range(0, len(data), DIRENTRY_SIZE):
+            entry = data[i : i + DIRENTRY_SIZE]
+
+            current_sector = start_sector + (i // SECTOR_SIZE)
+            current_offset = i % SECTOR_SIZE
+
+            if entry[0] == 0:
+                break
+            elif entry[0] == 0xE5:
+                # Deleted file
+                continue
+
+            if entry[11] & 0xF == 0xF:
+                # Long file name
+                continue
+
+            entries.append(
+                FatDirectoryEntry(entry, current_sector, current_offset)
+            )
+        return entries
+
+    def read_root_directory(self) -> List[FatDirectoryEntry]:
+        root_dir = self.read_sectors(
+            self.boot_sector.root_dir_start(), self.boot_sector.root_dir_size()
+        )
+        return self.directory_from_bytes(
+            root_dir, self.boot_sector.root_dir_start()
+        )
+
+    def read_fat_entry(self, cluster: int) -> int:
+        """
+        Read the FAT entry for the given cluster.
+        """
+        fat_offset = cluster * 2  # FAT16
+        return int.from_bytes(self.fats[fat_offset : fat_offset + 2], "little")
+
+    def write_fat_entry(self, cluster: int, value: int):
+        """
+        Write the FAT entry for the given cluster.
+        """
+        fat_offset = cluster * 2
+        self.fats = (
+            self.fats[:fat_offset]
+            + value.to_bytes(2, "little")
+            + self.fats[fat_offset + 2 :]
+        )
+        self.fats_dirty_sectors.add(fat_offset // SECTOR_SIZE)
+
+    def flush_fats(self):
+        """
+        Write the FATs back to the disk.
+        """
+        for sector in self.fats_dirty_sectors:
+            data = self.fats[sector * SECTOR_SIZE : (sector + 1) * SECTOR_SIZE]
+            sector = self.boot_sector.reserved_sectors + sector
+            self.write_sectors(sector, data)
+        self.fats_dirty_sectors = set()
+
+    def next_cluster(self, cluster: int) -> int | None:
+        """
+        Get the next cluster in the chain.
+        If its `None`, then its the last cluster.
+        The function will crash if the next cluster
+        is `FREE` (unexpected) or invalid entry.
+        """
+        fat_entry = self.read_fat_entry(cluster)
+        if fat_entry == 0:
+            raise Exception("Unexpected: FREE cluster")
+        elif fat_entry == 1:
+            raise Exception("Unexpected: RESERVED cluster")
+        elif fat_entry >= 0xFFF8:
+            return None
+        elif fat_entry >= 0xFFF7:
+            raise Exception("Invalid FAT entry")
+        else:
+            return fat_entry
+
+    def next_free_cluster(self) -> int:
+        """
+        Find the next free cluster.
+        """
+        # simple linear search
+        for i in range(2, 0xFFFF):
+            if self.read_fat_entry(i) == 0:
+                return i
+        raise Exception("No free clusters")
+
+    def next_free_cluster_non_continuous(self) -> int:
+        """
+        Find the next free cluster, but makes sure
+        that the cluster before and after it are not allocated.
+        """
+        # simple linear search
+        before = False
+        for i in range(2, 0xFFFF):
+            if self.read_fat_entry(i) == 0:
+                if before and self.read_fat_entry(i + 1) == 0:
+                    return i
+                else:
+                    before = True
+            else:
+                before = False
+
+        raise Exception("No free clusters")
+
+    def read_cluster(self, cluster: int) -> bytes:
+        """
+        Read the cluster at the given cluster.
+        """
+        return self.read_sectors(
+            self.boot_sector.first_sector_of_cluster(cluster),
+            self.boot_sector.sectors_per_cluster,
+        )
+
+    def write_cluster(self, cluster: int, data: bytes):
+        """
+        Write the cluster at the given cluster.
+        """
+        assert len(data) == self.boot_sector.cluster_bytes()
+        return self.write_sectors(
+            self.boot_sector.first_sector_of_cluster(cluster),
+            data,
+        )
+
+    def read_directory(self, cluster: int) -> List[FatDirectoryEntry]:
+        """
+        Read the directory at the given cluster.
+        """
+        entries = []
+        while cluster is not None:
+            data = self.read_cluster(cluster)
+            entries.extend(
+                self.directory_from_bytes(
+                    data, self.boot_sector.first_sector_of_cluster(cluster)
+                )
+            )
+            cluster = self.next_cluster(cluster)
+        return entries
+
+    def add_direntry(
+        self, cluster: int | None, name: str, ext: str, attributes: int
+    ):
+        """
+        Add a new directory entry to the given cluster.
+        If the cluster is `None`, then it will be added to the root directory.
+        """
+
+        def find_free_entry(data: bytes):
+            for i in range(0, len(data), DIRENTRY_SIZE):
+                entry = data[i : i + DIRENTRY_SIZE]
+                if entry[0] == 0 or entry[0] == 0xE5:
+                    return i
+            return None
+
+        assert len(name) <= 8, "Name must be 8 characters or less"
+        assert len(ext) <= 3, "Ext must be 3 characters or less"
+        assert attributes % 0x15 != 0x15, "Invalid attributes"
+
+        # initial dummy data
+        new_entry = FatDirectoryEntry(b"\0" * 32, 0, 0)
+        new_entry.name = name.ljust(8, " ")
+        new_entry.ext = ext.ljust(3, " ")
+        new_entry.attributes = attributes
+        new_entry.reserved = 0
+        new_entry.create_time_tenth = 0
+        new_entry.create_time = 0
+        new_entry.create_date = 0
+        new_entry.last_access_date = 0
+        new_entry.last_mod_time = 0
+        new_entry.last_mod_date = 0
+        new_entry.cluster = self.next_free_cluster()
+        new_entry.size_bytes = 0
+
+        # mark as EOF
+        self.write_fat_entry(new_entry.cluster, 0xFFFF)
+
+        if cluster is None:
+            for i in range(self.boot_sector.root_dir_size()):
+                sector_data = self.read_sectors(
+                    self.boot_sector.root_dir_start() + i, 1
+                )
+                offset = find_free_entry(sector_data)
+                if offset is not None:
+                    new_entry.sector = self.boot_sector.root_dir_start() + i
+                    new_entry.offset = offset
+                    self.update_direntry(new_entry)
+                    return new_entry
+        else:
+            while cluster is not None:
+                data = self.read_cluster(cluster)
+                offset = find_free_entry(data)
+                if offset is not None:
+                    new_entry.sector = self.boot_sector.first_sector_of_cluster(
+                        cluster
+                    ) + (offset // SECTOR_SIZE)
+                    new_entry.offset = offset % SECTOR_SIZE
+                    self.update_direntry(new_entry)
+                    return new_entry
+                cluster = self.next_cluster(cluster)
+
+        raise Exception("No free directory entries")
+
+    def update_direntry(self, entry: FatDirectoryEntry):
+        """
+        Write the directory entry back to the disk.
+        """
+        sector = self.read_sectors(entry.sector, 1)
+        sector = (
+            sector[: entry.offset]
+            + entry.as_bytes()
+            + sector[entry.offset + DIRENTRY_SIZE :]
+        )
+        self.write_sectors(entry.sector, sector)
+
+    def find_direntry(self, path: str) -> FatDirectoryEntry | None:
+        """
+        Find the directory entry for the given path.
+        """
+        assert path[0] == "/", "Path must start with /"
+
+        path = path[1:]  # remove the leading /
+        parts = path.split("/")
+        directory = self.read_root_directory()
+
+        current_entry = None
+
+        for i, part in enumerate(parts):
+            is_last = i == len(parts) - 1
+
+            for entry in directory:
+                if entry.whole_name() == part:
+                    current_entry = entry
+                    break
+            if current_entry is None:
+                return None
+
+            if is_last:
+                return current_entry
+            else:
+                if current_entry.attributes & 0x10 == 0:
+                    raise Exception(
+                        f"{current_entry.whole_name()} is not a directory"
+                    )
+                else:
+                    directory = self.read_directory(current_entry.cluster)
+
+    def read_file(self, entry: FatDirectoryEntry) -> bytes:
+        """
+        Read the content of the file at the given path.
+        """
+        if entry is None:
+            return None
+        if entry.attributes & 0x10 != 0:
+            raise Exception(f"{entry.whole_name()} is a directory")
+
+        data = b""
+        cluster = entry.cluster
+        while cluster is not None and len(data) <= entry.size_bytes:
+            data += self.read_cluster(cluster)
+            cluster = self.next_cluster(cluster)
+        return data[: entry.size_bytes]
+
+    def truncate_file(
+        self,
+        entry: FatDirectoryEntry,
+        new_size: int,
+        allocate_non_continuous: bool = False,
+    ):
+        """
+        Truncate the file at the given path to the new size.
+        """
+        if entry is None:
+            return Exception("entry is None")
+        if entry.attributes & 0x10 != 0:
+            raise Exception(f"{entry.whole_name()} is a directory")
+
+        def clusters_from_size(size: int):
+            return (
+                size + self.boot_sector.cluster_bytes() - 1
+            ) // self.boot_sector.cluster_bytes()
+
+        # First, allocate new FATs if we need to
+        required_clusters = clusters_from_size(new_size)
+        current_clusters = clusters_from_size(entry.size_bytes)
+
+        affected_clusters = set()
+
+        # Keep at least one cluster, easier to manage this way
+        if required_clusters == 0:
+            required_clusters = 1
+        if current_clusters == 0:
+            current_clusters = 1
+
+        if required_clusters > current_clusters:
+            # Allocate new clusters
+            cluster = entry.cluster
+            to_add = required_clusters
+            for _ in range(current_clusters - 1):
+                to_add -= 1
+                cluster = self.next_cluster(cluster)
+            assert required_clusters > 0, "No new clusters to allocate"
+            assert cluster is not None, "Cluster is None"
+            assert (
+                self.next_cluster(cluster) is None
+            ), "Cluster is not the last cluster"
+
+            # Allocate new clusters
+            for _ in range(to_add - 1):
+                new_cluster = self.next_free_cluster()
+                if allocate_non_continuous:
+                    new_cluster = self.next_free_cluster_non_continuous()
+                self.write_fat_entry(cluster, new_cluster)
+                self.write_fat_entry(new_cluster, 0xFFFF)
+                cluster = new_cluster
+
+        elif required_clusters < current_clusters:
+            # Truncate the file
+            cluster = entry.cluster
+            for _ in range(required_clusters - 1):
+                cluster = self.next_cluster(cluster)
+            assert cluster is not None, "Cluster is None"
+
+            next_cluster = self.next_cluster(cluster)
+            # mark last as EOF
+            self.write_fat_entry(cluster, 0xFFFF)
+            # free the rest
+            while next_cluster is not None:
+                cluster = next_cluster
+                next_cluster = self.next_cluster(next_cluster)
+                self.write_fat_entry(cluster, 0)
+
+        self.flush_fats()
+
+        # verify number of clusters
+        cluster = entry.cluster
+        count = 0
+        while cluster is not None:
+            count += 1
+            affected_clusters.add(cluster)
+            cluster = self.next_cluster(cluster)
+        assert (
+            count == required_clusters
+        ), f"Expected {required_clusters} clusters, got {count}"
+
+        # update the size
+        entry.size_bytes = new_size
+        self.update_direntry(entry)
+
+        # trigger every affected cluster
+        for cluster in affected_clusters:
+            first_sector = self.boot_sector.first_sector_of_cluster(cluster)
+            first_sector_data = self.read_sectors(first_sector, 1)
+            self.write_sectors(first_sector, first_sector_data)
+
+    def write_file(self, entry: FatDirectoryEntry, data: bytes):
+        """
+        Write the content of the file at the given path.
+        """
+        if entry is None:
+            return Exception("entry is None")
+        if entry.attributes & 0x10 != 0:
+            raise Exception(f"{entry.whole_name()} is a directory")
+
+        data_len = len(data)
+
+        self.truncate_file(entry, data_len)
+
+        cluster = entry.cluster
+        while cluster is not None:
+            data_to_write = data[: self.boot_sector.cluster_bytes()]
+            last_data = False
+            if len(data_to_write) < self.boot_sector.cluster_bytes():
+                last_data = True
+                old_data = self.read_cluster(cluster)
+                data_to_write += old_data[len(data_to_write) :]
+
+            self.write_cluster(cluster, data_to_write)
+            data = data[self.boot_sector.cluster_bytes() :]
+            if len(data) == 0:
+                break
+            cluster = self.next_cluster(cluster)
+
+        assert (
+            len(data) == 0
+        ), "Data was not written completely, clusters missing"
+
+    def create_file(self, path: str):
+        """
+        Create a new file at the given path.
+        """
+        assert path[0] == "/", "Path must start with /"
+
+        path = path[1:]  # remove the leading /
+
+        parts = path.split("/")
+
+        directory_cluster = None
+        directory = self.read_root_directory()
+
+        parts, filename = parts[:-1], parts[-1]
+
+        for i, part in enumerate(parts):
+            current_entry = None
+            for entry in directory:
+                if entry.whole_name() == part:
+                    current_entry = entry
+                    break
+            if current_entry is None:
+                return None
+
+            if current_entry.attributes & 0x10 == 0:
+                raise Exception(
+                    f"{current_entry.whole_name()} is not a directory"
+                )
+            else:
+                directory = self.read_directory(current_entry.cluster)
+                directory_cluster = current_entry.cluster
+
+        # add new entry to the directory
+
+        filename, ext = filename.split(".")
+
+        if len(ext) > 3:
+            raise Exception("Ext must be 3 characters or less")
+        if len(filename) > 8:
+            raise Exception("Name must be 8 characters or less")
+
+        for c in filename + ext:
+
+            if c not in ALLOWED_FILE_CHARS:
+                raise Exception("Invalid character in filename")
+
+        return self.add_direntry(directory_cluster, filename, ext, 0)
diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 588f30a4f1..4053d29de4 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -250,7 +250,7 @@ def __init__(self, source_dir: str, build_dir: str,
         self.qemu_img_options = os.getenv('QEMU_IMG_OPTIONS')
         self.qemu_nbd_options = os.getenv('QEMU_NBD_OPTIONS')
 
-        is_generic = self.imgfmt not in ['bochs', 'cloop', 'dmg']
+        is_generic = self.imgfmt not in ['bochs', 'cloop', 'dmg', 'vvfat']
         self.imgfmt_generic = 'true' if is_generic else 'false'
 
         self.qemu_io_options = f'--cache {self.cachemode} --aio {self.aiomode}'
diff --git a/tests/qemu-iotests/tests/vvfat b/tests/qemu-iotests/tests/vvfat
new file mode 100755
index 0000000000..aee5dfb3e2
--- /dev/null
+++ b/tests/qemu-iotests/tests/vvfat
@@ -0,0 +1,457 @@
+#!/usr/bin/env python3
+# group: rw vvfat
+#
+# Test vvfat driver implementation
+# Here, we use a simple FAT16 implementation and check the behavior of the vvfat driver.
+#
+# Copyright (C) 2024 Amjad Alsharafi <amjadsharafi10@gmail.com>
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
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+import os, shutil
+import iotests
+from iotests import imgfmt, QMPTestCase
+from fat16 import MBR, Fat16, DIRENTRY_SIZE
+
+filesystem = os.path.join(iotests.test_dir, "filesystem")
+
+nbd_sock = iotests.file_path("nbd.sock", base_dir=iotests.sock_dir)
+nbd_uri = "nbd+unix:///disk?socket=" + nbd_sock
+
+SECTOR_SIZE = 512
+
+
+class TestVVFatDriver(QMPTestCase):
+    def setUp(self) -> None:
+        if os.path.exists(filesystem):
+            if os.path.isdir(filesystem):
+                shutil.rmtree(filesystem)
+            else:
+                print(f"Error: {filesystem} exists and is not a directory")
+                exit(1)
+        os.mkdir(filesystem)
+
+        # Add some text files to the filesystem
+        for i in range(10):
+            with open(os.path.join(filesystem, f"file{i}.txt"), "w") as f:
+                f.write(f"Hello, world! {i}\n")
+
+        # Add 2 large files, above the cluster size (8KB)
+        with open(os.path.join(filesystem, "large1.txt"), "wb") as f:
+            # write 'A' * 1KB, 'B' * 1KB, 'C' * 1KB, ...
+            for i in range(8 * 2):  # two clusters
+                f.write(bytes([0x41 + i] * 1024))
+
+        with open(os.path.join(filesystem, "large2.txt"), "wb") as f:
+            # write 'A' * 1KB, 'B' * 1KB, 'C' * 1KB, ...
+            for i in range(8 * 3):  # 3 clusters
+                f.write(bytes([0x41 + i] * 1024))
+
+        self.vm = iotests.VM()
+
+        self.vm.add_blockdev(
+            self.vm.qmp_to_opts(
+                {
+                    "driver": imgfmt,
+                    "node-name": "disk",
+                    "rw": "true",
+                    "fat-type": "16",
+                    "dir": filesystem,
+                }
+            )
+        )
+
+        self.vm.launch()
+
+        self.vm.qmp_log("block-dirty-bitmap-add", **{"node": "disk", "name": "bitmap0"})
+
+        # attach nbd server
+        self.vm.qmp_log(
+            "nbd-server-start",
+            **{"addr": {"type": "unix", "data": {"path": nbd_sock}}},
+            filters=[],
+        )
+
+        self.vm.qmp_log(
+            "nbd-server-add",
+            **{"device": "disk", "writable": True, "bitmap": "bitmap0"},
+        )
+
+        self.qio = iotests.QemuIoInteractive("-f", "raw", nbd_uri)
+
+    def tearDown(self) -> None:
+        self.qio.close()
+        self.vm.shutdown()
+        # print(self.vm.get_log())
+        shutil.rmtree(filesystem)
+
+    def read_sectors(self, sector: int, num: int = 1) -> bytes:
+        """
+        Read `num` sectors starting from `sector` from the `disk`.
+        This uses `QemuIoInteractive` to read the sectors into `stdout` and then parse the output.
+        """
+        self.assertGreater(num, 0)
+        # The output contains the content of the sector in hex dump format
+        # We need to extract the content from it
+        output = self.qio.cmd(f"read -v {sector * SECTOR_SIZE} {num * SECTOR_SIZE}")
+        # Each row is 16 bytes long, and we are writing `num` sectors
+        rows = num * SECTOR_SIZE // 16
+        output_rows = output.split("\n")[:rows]
+
+        hex_content = "".join(
+            [(row.split(": ")[1]).split("  ")[0] for row in output_rows]
+        )
+        bytes_content = bytes.fromhex(hex_content)
+
+        self.assertEqual(len(bytes_content), num * SECTOR_SIZE)
+
+        return bytes_content
+
+    def write_sectors(self, sector: int, data: bytes):
+        """
+        Write `data` to the `disk` starting from `sector`.
+        This uses `QemuIoInteractive` to write the data into the disk.
+        """
+
+        self.assertGreater(len(data), 0)
+        self.assertEqual(len(data) % SECTOR_SIZE, 0)
+
+        temp_file = os.path.join(iotests.test_dir, "temp.bin")
+        with open(temp_file, "wb") as f:
+            f.write(data)
+
+        self.qio.cmd(f"write -s {temp_file} {sector * SECTOR_SIZE} {len(data)}")
+
+        os.remove(temp_file)
+
+    def init_fat16(self):
+        mbr = MBR(self.read_sectors(0))
+        return Fat16(
+            mbr.partition_table[0]["start_lba"],
+            mbr.partition_table[0]["size"],
+            self.read_sectors,
+            self.write_sectors,
+        )
+
+    # Tests
+
+    def test_fat_filesystem(self):
+        """
+        Test that vvfat produce a valid FAT16 and MBR sectors
+        """
+        mbr = MBR(self.read_sectors(0))
+
+        self.assertEqual(mbr.partition_table[0]["status"], 0x80)
+        self.assertEqual(mbr.partition_table[0]["type"], 6)
+
+        fat16 = Fat16(
+            mbr.partition_table[0]["start_lba"],
+            mbr.partition_table[0]["size"],
+            self.read_sectors,
+            self.write_sectors,
+        )
+        self.assertEqual(fat16.boot_sector.bytes_per_sector, 512)
+        self.assertEqual(fat16.boot_sector.volume_label, "QEMU VVFAT")
+
+    def test_read_root_directory(self):
+        """
+        Test the content of the root directory
+        """
+        fat16 = self.init_fat16()
+
+        root_dir = fat16.read_root_directory()
+
+        self.assertEqual(len(root_dir), 13)  # 12 + 1 special file
+
+        files = {
+            "QEMU VVF.AT": 0,  # special empty file
+            "FILE0.TXT": 16,
+            "FILE1.TXT": 16,
+            "FILE2.TXT": 16,
+            "FILE3.TXT": 16,
+            "FILE4.TXT": 16,
+            "FILE5.TXT": 16,
+            "FILE6.TXT": 16,
+            "FILE7.TXT": 16,
+            "FILE8.TXT": 16,
+            "FILE9.TXT": 16,
+            "LARGE1.TXT": 0x2000 * 2,
+            "LARGE2.TXT": 0x2000 * 3,
+        }
+
+        for entry in root_dir:
+            self.assertIn(entry.whole_name(), files)
+            self.assertEqual(entry.size_bytes, files[entry.whole_name()])
+
+    def test_direntry_as_bytes(self):
+        """
+        Test if we can convert Direntry back to bytes, so that we can write it back to the disk safely.
+        """
+        fat16 = self.init_fat16()
+
+        root_dir = fat16.read_root_directory()
+        first_entry_bytes = fat16.read_sectors(fat16.boot_sector.root_dir_start(), 1)
+        # The first entry won't be deleted, so we can compare it with the first entry in the root directory
+        self.assertEqual(root_dir[0].as_bytes(), first_entry_bytes[:DIRENTRY_SIZE])
+
+    def test_read_files(self):
+        """
+        Test reading the content of the files
+        """
+        fat16 = self.init_fat16()
+
+        for i in range(10):
+            file = fat16.find_direntry(f"/FILE{i}.TXT")
+            self.assertIsNotNone(file)
+            self.assertEqual(
+                fat16.read_file(file), f"Hello, world! {i}\n".encode("ascii")
+            )
+
+        # test large files
+        large1 = fat16.find_direntry("/LARGE1.TXT")
+        with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
+            self.assertEqual(fat16.read_file(large1), f.read())
+
+        large2 = fat16.find_direntry("/LARGE2.TXT")
+        self.assertIsNotNone(large2)
+        with open(os.path.join(filesystem, "large2.txt"), "rb") as f:
+            self.assertEqual(fat16.read_file(large2), f.read())
+
+    def test_write_file_same_content_direct(self):
+        """
+        Similar to `test_write_file_in_same_content`, but we write the file directly clusters
+        and thus we don't go through the modification of direntry.
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/FILE0.TXT")
+        self.assertIsNotNone(file)
+
+        data = fat16.read_cluster(file.cluster)
+        fat16.write_cluster(file.cluster, data)
+
+        with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
+            self.assertEqual(fat16.read_file(file), f.read())
+
+    def test_write_file_in_same_content(self):
+        """
+        Test writing the same content to the file back to it
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/FILE0.TXT")
+        self.assertIsNotNone(file)
+
+        self.assertEqual(fat16.read_file(file), b"Hello, world! 0\n")
+
+        fat16.write_file(file, b"Hello, world! 0\n")
+        self.assertEqual(fat16.read_file(file), b"Hello, world! 0\n")
+
+        with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
+            self.assertEqual(f.read(), b"Hello, world! 0\n")
+
+    def test_modify_content_same_clusters(self):
+        """
+        Test modifying the content of the file without changing the number of clusters
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/FILE0.TXT")
+        self.assertIsNotNone(file)
+
+        new_content = b"Hello, world! Modified\n"
+        self.assertEqual(fat16.read_file(file), b"Hello, world! 0\n")
+
+        fat16.write_file(file, new_content)
+        self.assertEqual(fat16.read_file(file), new_content)
+
+        with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    def test_truncate_file_same_clusters_less(self):
+        """
+        Test truncating the file without changing number of clusters
+        Test decreasing the file size
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/FILE0.TXT")
+        self.assertIsNotNone(file)
+
+        self.assertEqual(fat16.read_file(file), b"Hello, world! 0\n")
+
+        fat16.truncate_file(file, 5)
+        new_content = fat16.read_file(file)
+        self.assertEqual(new_content, b"Hello")
+
+        with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    def test_truncate_file_same_clusters_more(self):
+        """
+        Test truncating the file without changing number of clusters
+        Test increase the file size
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/FILE0.TXT")
+        self.assertIsNotNone(file)
+
+        self.assertEqual(fat16.read_file(file), b"Hello, world! 0\n")
+
+        fat16.truncate_file(file, 20)
+        new_content = fat16.read_file(file)
+
+        # random pattern will be appended to the file, and its not always the same
+        self.assertEqual(new_content[:16], b"Hello, world! 0\n")
+        self.assertEqual(len(new_content), 20)
+
+        with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    def test_write_large_file(self):
+        """
+        Test writing a large file
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/LARGE1.TXT")
+        self.assertIsNotNone(file)
+
+        # The content of LARGE1 is A * 1KB, B * 1KB, C * 1KB, ..., P * 1KB
+        # Lets change it to be Z * 1KB, Y * 1KB, X * 1KB, ..., K * 1KB
+        # without changing the number of clusters or filesize
+        new_content = b"".join([bytes([0x5A - i] * 1024) for i in range(16)])
+        fat16.write_file(file, new_content)
+        self.assertEqual(fat16.read_file(file), new_content)
+
+        with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    def test_truncate_file_change_clusters_less(self):
+        """
+        Test truncating a file by reducing the number of clusters
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/LARGE1.TXT")
+        self.assertIsNotNone(file)
+
+        fat16.truncate_file(file, 1)
+        self.assertEqual(fat16.read_file(file), b"A")
+
+        with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
+            self.assertEqual(f.read(), b"A")
+
+    def test_write_file_change_clusters_less(self):
+        """
+        Test truncating a file by reducing the number of clusters
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/LARGE2.TXT")
+        self.assertIsNotNone(file)
+
+        new_content = b"X" * 8 * 1024 + b"Y" * 8 * 1024
+        fat16.write_file(file, new_content)
+        self.assertEqual(fat16.read_file(file), new_content)
+
+        with open(os.path.join(filesystem, "large2.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    def test_write_file_change_clusters_more(self):
+        """
+        Test truncating a file by increasing the number of clusters
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/LARGE2.TXT")
+        self.assertIsNotNone(file)
+
+        # from 3 clusters to 4 clusters
+        new_content = (
+            b"W" * 8 * 1024 + b"X" * 8 * 1024 + b"Y" * 8 * 1024 + b"Z" * 8 * 1024
+        )
+        fat16.write_file(file, new_content)
+        self.assertEqual(fat16.read_file(file), new_content)
+
+        with open(os.path.join(filesystem, "large2.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    def test_write_file_change_clusters_more_non_contiguous_2_mappings(self):
+        """
+        Test truncating a file by increasing the number of clusters
+        Here we allocate the new clusters in a way that makes them non-contiguous
+        so that we will get 2 cluster mappings for the file
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/LARGE1.TXT")
+        self.assertIsNotNone(file)
+
+        # from 2 clusters to 3 clusters with non-contiguous allocation
+        fat16.truncate_file(file, 3 * 0x2000, allocate_non_continuous=True)
+        new_content = b"X" * 8 * 1024 + b"Y" * 8 * 1024 + b"Z" * 8 * 1024
+        fat16.write_file(file, new_content)
+        self.assertEqual(fat16.read_file(file), new_content)
+
+        with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    def test_write_file_change_clusters_more_non_contiguous_3_mappings(self):
+        """
+        Test truncating a file by increasing the number of clusters
+        Here we allocate the new clusters in a way that makes them non-contiguous
+        so that we will get 3 cluster mappings for the file
+        """
+        fat16 = self.init_fat16()
+
+        file = fat16.find_direntry("/LARGE1.TXT")
+        self.assertIsNotNone(file)
+
+        # from 2 clusters to 4 clusters with non-contiguous allocation
+        fat16.truncate_file(file, 4 * 0x2000, allocate_non_continuous=True)
+        new_content = (
+            b"W" * 8 * 1024 + b"X" * 8 * 1024 + b"Y" * 8 * 1024 + b"Z" * 8 * 1024
+        )
+        fat16.write_file(file, new_content)
+        self.assertEqual(fat16.read_file(file), new_content)
+
+        with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    def test_create_file(self):
+        """
+        Test creating a new file
+        """
+        fat16 = self.init_fat16()
+
+        new_file = fat16.create_file("/NEWFILE.TXT")
+
+        self.assertIsNotNone(new_file)
+        self.assertEqual(new_file.size_bytes, 0)
+
+        new_content = b"Hello, world! New file\n"
+        fat16.write_file(new_file, new_content)
+        self.assertEqual(fat16.read_file(new_file), new_content)
+
+        with open(os.path.join(filesystem, "newfile.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    # TODO: support deleting files
+
+
+if __name__ == "__main__":
+    # This is a specific test for vvfat driver
+    iotests.main(supported_fmts=["vvfat"], supported_protocols=["file"])
diff --git a/tests/qemu-iotests/tests/vvfat.out b/tests/qemu-iotests/tests/vvfat.out
new file mode 100755
index 0000000000..b6f257674e
--- /dev/null
+++ b/tests/qemu-iotests/tests/vvfat.out
@@ -0,0 +1,5 @@
+................
+----------------------------------------------------------------------
+Ran 16 tests
+
+OK
-- 
2.45.1


