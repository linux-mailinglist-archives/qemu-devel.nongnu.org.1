Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6C736ABD
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:18:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZMo-000399-Ea; Tue, 20 Jun 2023 07:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qBZMm-00037D-7k
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:17:44 -0400
Received: from mr85p00im-zteg06021901.me.com ([17.58.23.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qBZMj-0006jn-PE
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1687259859; bh=dG5Rc0PCllhhaYpBxMghZWbAcodEUEjgv6iCawS3ORM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=c2ILi5ag640YDiy22KuJOQ5LPxYFNglWipXYk2DIU1M0Gk00J9HGiztddMYbweNnm
 gkoTUP8D1ZPfQcndbDF/vMoqsK09P3Xv3XMWyH1KdfsD47vN327RfdhsZhNtx3Rusm
 nKZqGEGuyo8LoLQf0zZIJCAJzOW9CxwPGG0GFGxpr9RLT9bLfSyDuWsjKPNBmqzcUF
 YYOTS537ivl2I6UGkEW42m2EJN69+eUARy5eSSyQ4WeAZGPVVe1gR+mKILU6kKLI90
 +sKqifZXXiWYTZ6ZyhEzN4z96n8cWiVf1vQ5mWqwO1DWotB2UZxcMJfFx2zLtKc2+F
 d5AxNT8WSuPBQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com
 [17.57.152.18])
 by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id 38D4774006D;
 Tue, 20 Jun 2023 11:17:36 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 00/12] Introduce new vmapple machine type
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20230614224038.86148-1-graf@amazon.com>
Date: Tue, 20 Jun 2023 13:17:23 +0200
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 "open list:ARM cores" <qemu-arm@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Transfer-Encoding: 7bit
Message-Id: <ACE1A94A-4CB8-4B23-B09A-D2B1685E402E@ynddal.dk>
References: <20230614224038.86148-1-graf@amazon.com>
To: Alexander Graf <graf@amazon.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Proofpoint-GUID: uXnx1zlMLQ7Nu4NAVJoZNbwry9ZOmjvX
X-Proofpoint-ORIG-GUID: uXnx1zlMLQ7Nu4NAVJoZNbwry9ZOmjvX
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 clxscore=1030 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306200101
Received-SPF: pass client-ip=17.58.23.194; envelope-from=mads@ynddal.dk;
 helo=mr85p00im-zteg06021901.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


> On 15 Jun 2023, at 00.40, Alexander Graf <graf@amazon.com> wrote:
> 
> This patch set introduces a new ARM and HVF specific machine type
> called "vmapple". It mimicks the device model that Apple's proprietary
> Virtualization.Framework exposes, but implements it in QEMU.
> 
> With this new machine type, you can run macOS guests on Apple Silicon
> systems via HVF. To do so, you need to first install macOS using
> Virtualization.Framework onto a virtual disk image using a tool like
> macosvm (https://github.com/s-u/macosvm)
> 
>  $ macosvm --disk disk.img,size=32g --aux aux.img \
>            --restore UniversalMac_12.0.1_21A559_Restore.ipsw vm.json
> 
> Then, extract the ECID from the installed VM:
> 
>  $ cat "$DIR/macosvm.json" | python3 -c                                 \
>  'import json,sys;obj=json.load(sys.stdin);print(obj["machineId"]) |    \
>  base64 -d | plutil -extract ECID raw -

Beware, that the file will be called 'vm.json' and DIR is undefined following
the previous line. Also, it's missing a single-quote at the end of
`["machineId"])`.

> In addition, cut off the first 16kb of the aux.img:
> 
>  $ dd if=aux.img of=aux.img.trimmed bs=$(( 0x4000 )) skip=1
> 
> Now, you can just launch QEMU with the bits generated above:
> 
>  $ qemu-system-aarch64 -serial mon:stdio                                \
>  -m 4G                                                                  \
>  -M vmapple,uuid=6240349656165161789                                    \
>  -bios /Sys*/Lib*/Fra*/Virtualization.f*/R*/AVPBooter.vmapple2.bin      \
>  -pflash aux.img.trimmed                                                \
>  -pflash disk.img                                                       \
>  -drive file=disk.img,if=none,id=root                                   \
>  -device virtio-blk-pci,drive=root,x-apple-type=1                       \
>  -drive file=aux.img.trimmed,if=none,id=aux                             \
>  -device virtio-blk-pci,drive=aux,x-apple-type=2                        \
>  -accel hvf -no-reboot

Just for clarity, I'd add that the 'vmapple,uuid=...' has to be set to the
ECID the previous step.

You haven't defined a display, but I'm not sure if that is on purpose to
show a minimal setup. I had to add '-display sdl' for it to fully work.

> There are a few limitations with this implementation:
> 
>  - Only runs on macOS because it relies on
>    ParavirtualizesGraphics.Framework
>  - Something is not fully correct on interrupt delivery or
>    similar - the keyboard does not work
>  - No Rosetta in the guest because we lack the private
>    entitlement to enable TSO

Would it be possible to mitigate the keyboard issue using an emulated USB
keyboard? I tried poking around with it, but with no success.

> Over time, I hope that some of the limitations above could cease to exist.
> This device model would enable very nice use cases with KVM on an Asahi
> Linux device.




