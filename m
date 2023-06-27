Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AF67401FF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 19:20:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qECKl-00062x-CO; Tue, 27 Jun 2023 13:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1qECKa-0005xv-Hy
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:18:20 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1qECKX-0006Ot-2k
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vZNom1S9UEKkFH3jeHCnReQzdj9+4WycGzz9hGTRgzU=; b=P6+yZ2CJV+Lw1zMHLVy8vibBQj
 /CkF/acatMxO1erz0K8Y3wlV0eCZ3FZq1vjX3Tqt9m2ddDZ06zuXmo3XCmF8FaXgHB24jeKiWYwMS
 BYVc6n6BDZvfwOCGTYjfqjHLPnpIRGvxn8psAdcoKamRbH41mFsC/G2/j16m5OePJiw0o6IoqE4DR
 0NKdK38k0/rlFUgsMXLRDfCCdoFmjXMJuJzSzc/TS2LdjwEqr2AvuzjpBimzVNuwYIv5jA0F7EE+w
 FQhjuwwRV7V17HJDH6zTA85PvV9djvJeRdeWqXyNqQppZV1nGa13D5dsicNSqg9sr4fYO+KJNCIUK
 8Pi9j9jQ==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.96-58-g4e9ed49f8)
 (envelope-from <hc981@poolhem.se>) id 1qECKV-00DylI-2W;
 Tue, 27 Jun 2023 19:18:15 +0200
Date: Tue, 27 Jun 2023 19:18:09 +0200
From: Henrik Carlqvist <hc981@poolhem.se>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v8] Emulate dip switch language layout settings on SUN
 keyboard
Message-Id: <20230627191809.66da4f26.hc981@poolhem.se>
In-Reply-To: <ac53e898-a50c-bbde-4232-541547d1ec82@ilande.co.uk>
References: <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
 <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se>
 <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
 <ZJKiGBJNQa5Kx+Dg@redhat.com>
 <20230621201447.712ec73a.hc94@poolhem.se>
 <20230623203007.56d3d182.hc981@poolhem.se>
 <ac53e898-a50c-bbde-4232-541547d1ec82@ilande.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=2a0b:dc80:cafe:112::1;
 envelope-from=hc981@poolhem.se; helo=mailout12.inleed.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Tue, 27 Jun 2023 07:33:46 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:
> I think this is about ready to merge: the only thing I'd like to change is
> to swap unsigned char to uint8_t in the signature of
> sunkbd_layout_dip_switch(), but I can fix that up myself and queue it to my
> qemu-sparc branch.

Thanks for accepting my patch! Please let me know if you want me to do
anything more!

Best regards Henrik

