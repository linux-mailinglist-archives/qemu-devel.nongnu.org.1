Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E47EB38C
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:29:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2vKr-0002Bj-4Q; Tue, 14 Nov 2023 10:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a8e905033730cff805ca+7387+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r2vKo-0002AW-Na; Tue, 14 Nov 2023 10:28:14 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+a8e905033730cff805ca+7387+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r2vKm-0001Jy-PK; Tue, 14 Nov 2023 10:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=N6lsIAvT/LEG0QMHScLeB5rAujKwbWfIcynqEX/JTgg=; b=Q8wLxLTE99gkmHRWLTsrO2SdeW
 XfdKzTjDRskRz4FgWweoVthPGWW6En3PnTPFiWPPGI0GLEqYKFCbaeUhWCc7eqRld+EkmItyFum/u
 f8mR/LaDGf97Vypg8dR70A9njyk0ujfA7GZDBcceSMpPvIfPG8ySvMi5k6XkPRB+nhXIzXfrUJtqt
 0clzgOwbYlqSSo1XvNoqUO0a+GmML4/eWxE/IEVjTty/Z4Wj8qtR55DQRxJj44VukxbGuuQxa91Un
 cEKKoaJzdph/iZGXdVUaBR1VS+02QOG0uU75aMm/LiOK4lkOlIuQpg//W3mDTgD24Mh/X3NI0TbGv
 wu90QKlA==;
Received: from [12.186.190.2] (helo=[127.0.0.1])
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r2vKf-008iHm-67; Tue, 14 Nov 2023 15:28:05 +0000
Date: Tue, 14 Nov 2023 10:27:59 -0500
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
 Thomas Huth <thuth@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH-for-9=2E0_v2_07/19=5D_hw/xen=3A_Rem?=
 =?US-ASCII?Q?ove_unnecessary_xen=5Fhvm=5Finject=5Fmsi=28=29_stub?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231114143816.71079-8-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-8-philmd@linaro.org>
Message-ID: <017E3F40-47A2-4F1D-98B6-18863ABB0FD6@infradead.org>
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

On 14 November 2023 09:38:03 GMT-05:00, "Philippe Mathieu-Daud=C3=A9" <phil=
md@linaro=2Eorg> wrote:
>Since commit 04b0de0ee8 ("xen: factor out common functions")
>xen_hvm_inject_msi() stub is not required=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Reviewed-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>



