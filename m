Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D07C9FBC
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:41:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsHGv-0007Rv-Gp; Mon, 16 Oct 2023 02:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qsHGt-0007Ri-JT; Mon, 16 Oct 2023 02:40:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qsHGq-0006q5-5O; Mon, 16 Oct 2023 02:40:11 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39G6dt4a006482; Mon, 16 Oct 2023 06:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9t31TBbP2136IGjyUIErRQJhhM56U90c2dAQPJ/Zq8o=;
 b=kcyUi1XIwJsftviESzO2zx2pC8MNlfKxdrIBaxxtTT8CzuJHwrjp5hPVDsOMLrCFEWfy
 c5ec33Q2Xjz3SfULeIQhgqr2M2dOP7XoKHCzhAKLp71dDvY3OH2SZU23I9gvE+LKWGfn
 Ex+q+mdm8IL5/8BWxF3+fQ20EPwEGGVdQRRhZTelPC0zsyF+TDgpoDg8swIGFmccyJUa
 wxfLPJgKWVaOlQy71snH/uLiT7D8ah1PKAeEZb84CceaG3G71TNkfaFuXXc7MBT9GffE
 R75XMhy7OjvWShgohGYGDA1Ee/tatZo6HwiYrhKoAYjZpGbGFOv7mZFrunRskZvWvV9t xA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts03sr07s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 06:40:04 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39G6e3BV006960;
 Mon, 16 Oct 2023 06:40:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts03sr07b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 06:40:03 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39G3jHlr027163; Mon, 16 Oct 2023 06:40:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tjxufc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 06:40:03 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39G6e22L3539664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 06:40:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACF545805F;
 Mon, 16 Oct 2023 06:40:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 772EA58043;
 Mon, 16 Oct 2023 06:39:59 +0000 (GMT)
Received: from [9.109.242.129] (unknown [9.109.242.129])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 06:39:59 +0000 (GMT)
Message-ID: <71f24978-a443-716c-cb9f-69007f1e893f@linux.ibm.com>
Date: Mon, 16 Oct 2023 12:09:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 04/11] tests/avocado: ppc add hypervisor tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 anushree.mathur@linux.ibm.com, hariharan.ts@linux.vnet.ibm.com
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-5-npiggin@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20231010075238.95646-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XUPVw4e5jQIXXgKhmQxtpEilnNU3tAaa
X-Proofpoint-GUID: XUCPmcSrVNd3xEtf174aevApYeULXjXg
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-15_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310160056
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+ Anushree, Hari - FYI

On 10/10/23 13:22, Nicholas Piggin wrote:
> The powernv and pseries machines both provide hypervisor facilities,
> which is a large and complicated set of features that don't get much
> system testing in CI.
> 
> Add a new test case for these which runs QEMU KVM inside the target.
> ---
>   tests/avocado/ppc_hv_tests.py | 173 ++++++++++++++++++++++++++++++++++
>   1 file changed, 173 insertions(+)
>   create mode 100644 tests/avocado/ppc_hv_tests.py
> 
> diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
> new file mode 100644
> index 0000000000..16aac1d35d
> --- /dev/null
> +++ b/tests/avocado/ppc_hv_tests.py
> @@ -0,0 +1,173 @@
> +# Tests that specifically try to exercise hypervisor features of the
> +# target machines. powernv supports the Power hypervisor ISA, and
> +# pseries supports the nested-HV hypervisor spec.
> +#
> +# Copyright (c) 2023 IBM Corporation
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado import skipIf
> +from avocado.utils import archive
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import wait_for_console_pattern, exec_command
> +import os
> +import time
> +import subprocess
> +
> +# Alpine is a light weight distro that supports QEMU. These tests boot
> +# that on the machine then run a QEMU guest inside it in KVM mode,
> +# that runs the same Alpine distro image.
> +# QEMU packages are downloaded and installed on each test. That's not a
> +# large download, but it may be more polite to create qcow2 image with
> +# QEMU already installed and use that.
> +class HypervisorTest(QemuSystemTest):
> +
> +    timeout = 600
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
> +    panic_message = 'Kernel panic - not syncing'
> +    good_message = 'VFS: Cannot open root device'
> +
> +    def extract_from_iso(self, iso, path):
> +        """
> +        Extracts a file from an iso file into the test workdir
> +
> +        :param iso: path to the iso file
> +        :param path: path within the iso file of the file to be extracted
> +        :returns: path of the extracted file
> +        """
> +        filename = os.path.basename(path)
> +
> +        cwd = os.getcwd()
> +        os.chdir(self.workdir)
> +
> +        with open(filename, "w") as outfile:
> +            cmd = "isoinfo -i %s -R -x %s" % (iso, path)
> +            subprocess.run(cmd.split(), stdout=outfile)
> +
> +        os.chdir(cwd)
> +
> +        # Return complete path to extracted file.  Because callers to
> +        # extract_from_iso() specify 'path' with a leading slash, it is
> +        # necessary to use os.path.relpath() as otherwise os.path.join()
> +        # interprets it as an absolute path and drops the self.workdir part.
> +        return os.path.normpath(os.path.join(self.workdir, filename))
> +
> +    def do_start_alpine(self):
> +        iso_url = ('https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso')
> +
> +        # Alpine use sha256 so I recalculated this myself
> +        iso_sha256 = 'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff'
> +        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha256,
> +                                    algorithm = "sha256")
> +
> +        vmlinuz = self.extract_from_iso(iso_path, '/boot/vmlinuz-lts')
> +        initramfs = self.extract_from_iso(iso_path, '/boot/initramfs-lts')
> +
> +        self.vm.set_console()
> +        self.vm.add_args("-kernel", vmlinuz)
> +        self.vm.add_args("-initrd", initramfs)
> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
> +                               'console=hvc0')

console=hvc0 was already added to KERNEL_COMMON_COMMAND_LINE during init.

> +        self.require_accelerator("tcg")
> +
> +        self.vm.add_args("-accel", "tcg,thread=multi")
> +        self.vm.add_args("-smp", "4", "-m", "2g")
> +        self.vm.add_args("-drive", f"file={iso_path},format=raw,if=none,id=drive0")
> +#        self.vm.add_args("-drive", f"file={iso_path},format=raw")

commented code can be removed.

> +
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
> +        exec_command(self, 'root')
> +        wait_for_console_pattern(self, 'localhost login:')
> +        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
> +        exec_command(self, 'setup-alpine -qe')
> +        wait_for_console_pattern(self, 'localhost:~#')
> +
> +    def do_stop_alpine(self):
> +        exec_command(self, 'poweroff')
> +        wait_for_console_pattern(self, 'alpine:~#')
> +        self.vm.wait()
> +
> +    def do_setup_kvm(self):
> +        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/main > /etc/apk/repositories')
> +        wait_for_console_pattern(self, 'alpine:~#')
> +        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/community >> /etc/apk/repositories')
> +        wait_for_console_pattern(self, 'alpine:~#')
> +        exec_command(self, 'apk update')
> +        wait_for_console_pattern(self, 'alpine:~#')
> +        exec_command(self, 'apk add qemu-system-ppc64')
> +        wait_for_console_pattern(self, 'alpine:~#')
> +        exec_command(self, 'modprobe kvm-hv')
> +        wait_for_console_pattern(self, 'alpine:~#')
> +
> +    def do_test_kvm(self, hpt=False):
> +        if hpt:
> +            append = 'disable_radix'
> +        else:
> +            append = ''
> +        exec_command(self, 'qemu-system-ppc64 -nographic -smp 2 -m 1g '
> +                           '-machine pseries,x-vof=on,accel=kvm '
> +                           '-machine cap-cfpc=broken,cap-sbbc=broken,'
> +                                    'cap-ibs=broken,cap-ccf-assist=off '
> +                           '-drive file=/dev/nvme0n1,format=raw,readonly=on '
> +                           '-initrd /media/nvme0n1/boot/initramfs-lts '
> +                           '-kernel /media/nvme0n1/boot/vmlinuz-lts '
> +                           '-append \'usbcore.nousb ' + append + '\'')
> +        # Alpine 3.18 kernel seems to crash in XHCI USB driver.
> +        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
> +        exec_command(self, 'root')
> +        wait_for_console_pattern(self, 'localhost login:')
> +        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
> +        exec_command(self, 'poweroff >& /dev/null')
> +        wait_for_console_pattern(self, 'localhost:~#')
> +        wait_for_console_pattern(self, 'reboot: Power down')
> +        time.sleep(1)
> +        exec_command(self, '') # console has strange issue after qemu exit
> +        exec_command(self, 'reset')
> +        exec_command(self, 'echo VM finished')
> +        wait_for_console_pattern(self, 'VM finished')
> +
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_hv_pseries(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:tcg
> +        """
> +        self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
> +        self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on")
> +        self.do_start_alpine()
> +        self.do_setup_kvm()
> +        self.do_test_kvm()
> +        self.do_stop_alpine()
> +
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_hv_pseries_kvm(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:kvm
> +        """
> +        self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
> +        self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on")

Is this meant to launch an L0 with KVM accel on pseries with 
cap-nested-hv=on and then do another nested guest using KVM (with below 
steps). Is cap-nested-hv really supported on actual pseries LPARs yet?

regards,
Harsh

> +        self.do_start_alpine()
> +        self.do_setup_kvm()
> +        self.do_test_kvm()
> +        self.do_stop_alpine()
> +
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    def test_hv_powernv(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv
> +        :avocado: tags=accel:tcg
> +        """
> +        self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
> +                         '-device', 'e1000e,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pcie.0,addr=0x0',
> +                         '-netdev', 'user,id=net0,hostfwd=::20022-:22,hostname=alpine')
> +        self.do_start_alpine()
> +        self.do_setup_kvm()
> +        self.do_test_kvm()
> +        self.do_test_kvm(True)
> +        self.do_stop_alpine()

