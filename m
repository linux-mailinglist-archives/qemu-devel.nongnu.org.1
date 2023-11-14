Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 333317EB30C
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2v1r-0005RE-OZ; Tue, 14 Nov 2023 10:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a8e905033730cff805ca+7387+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r2v1i-0005Px-1t; Tue, 14 Nov 2023 10:08:30 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a8e905033730cff805ca+7387+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r2v1d-0005Wi-HG; Tue, 14 Nov 2023 10:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=gPlTnLrWpPWWoUPGEpERtBAlyTDR8Uk7y5kKdp/k5WQ=; b=u1gqmmwUiYpHqi0uHXy3+ToCOg
 KHEul+myRl+dxaYk/qNKWcNttIq8/dZePgwrAoIO8+fIFGcpyX/LBLL2RF3dFIzW6YXDETCZ5hfdq
 YZnC8QwR/QP/IvY2HE0U0K/ebiBiubW4IMEq4rDgmwiw4LF9zQ9Px1M/iVxncLveLC5156Q51zRLu
 GjIunmXq7yWhG/pb+jRvc4LqTUV4u3FdRaGslz3bGN3HeiCKr/xGZcicCi1VgEx37L59bWG6O/YPG
 /eR3o3YdWcexfFKmcOp0M3zHSiDW5cr8dZvQU9Ui86+l8t77xJryJcV0HGOzffZh0FI7e30+d1pvR
 v+oQjvuA==;
Received: from [12.186.190.2] (helo=[127.0.0.1])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r2v1Q-008cvI-6u; Tue, 14 Nov 2023 15:08:12 +0000
Date: Tue, 14 Nov 2023 10:08:09 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
CC: =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH-for-9=2E0_v2_01/19=5D_tests/avocado=3A_A?=
 =?US-ASCII?Q?dd_=27guest=3Axen=27_tag_to_tests_running_Xen_guest?=
User-Agent: K-9 Mail for Android
In-Reply-To: <407f32ee-e489-4c05-9c3d-fa6c29bb1d99@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-2-philmd@linaro.org>
 <94D9484A-917D-4970-98DE-35B84BEDA1DC@infradead.org>
 <407f32ee-e489-4c05-9c3d-fa6c29bb1d99@linaro.org>
Message-ID: <074BCACF-C8D0-440A-A805-CDB0DB21C416@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+a8e905033730cff805ca+7387+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 14 November 2023 10:00:09 GMT-05:00, "Philippe Mathieu-Daud=C3=A9" <phil=
md@linaro=2Eorg> wrote:
>On 14/11/23 15:50, David Woodhouse wrote:
>> On 14 November 2023 09:37:57 GMT-05:00, "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg> wrote:
>>> Add a tag to run all Xen-specific tests using:
>>>=20
>>>   $ make check-avocado AVOCADO_TAGS=3D'guest:xen'
>>>=20
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>> ---
>>> tests/avocado/boot_xen=2Epy      | 3 +++
>>> tests/avocado/kvm_xen_guest=2Epy | 1 +
>>> 2 files changed, 4 insertions(+)
>>=20
>> Those two are very different=2E One runs on Xen, the other on KVM=2E Do=
 we want to use the same tag for both?
>
>My understanding is,
>- boot_xen=2Epy runs Xen on TCG
>- kvm_xen_guest=2Epy runs Xen on KVM
>so both runs Xen guests=2E

Does boot_xen=2Epy actually boot *Xen*? And presumably at least one Xen gu=
est *within* Xen?

kvm_xen_guest=2Epy boots a "Xen guest" under KVM directly without any real=
 Xen being present=2E It's *emulating* Xen=2E

They do both run Xen guests (or at least guests which use Xen hypercalls a=
nd *think* they're running under Xen)=2E But is that the important classifi=
cation for lumping them together?


