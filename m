Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C867286EC
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 20:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7K7e-0003yb-L7; Thu, 08 Jun 2023 14:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1q7K7c-0003y9-3T
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:12:32 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1q7K7Z-0003SX-Ob
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 14:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1+1xMRc352AQSWKMLml0nK0fnSJg6h/nnVpUsR4TuhM=; b=dK4yoVr4egSClfD5mzsm+V1zsD
 PqHx8qgyf1ZtqDvYsVTvNp9OjnuA8UcQl1o4Fh7Ya8e1UJ7FxJsfaoEFsnOr2agSZ70U/Aqaht7du
 ZmFmSjCSdmqmIijR06WQVfs5waXXv+BDzlJ6Hw9jQACakn19Ion/nOoUfbTTrBDiC74WJj11VdSd2
 32IrRkICytjE2EyysPmIjHX2yu40GAB+z9lS8R3y41PjOwXNredHNUbwGsB60GQ6UqXy3cf/5iWo+
 L9UoDaPd2oog5X7NBszNuuZP4Ntr/XOfFUlyF5x8MYZH95Yb5Ydy3cP980NW2H03EBWDFzlwGVPGy
 ImuiGIEw==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.96-58-g4e9ed49f8)
 (envelope-from <hc981@poolhem.se>) id 1q7K7X-003Kyv-0L;
 Thu, 08 Jun 2023 20:12:27 +0200
Date: Thu, 8 Jun 2023 20:12:21 +0200
From: Henrik Carlqvist <hc981@poolhem.se>
To: Daniel P. =?ISO-8859-1?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: mark.cave-ayland@ilande.co.uk, hc1245@poolhem.se, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] Emulate dip switch language layout settings on SUN
 keyboard
Message-Id: <20230608201221.376ca6ce.hc981@poolhem.se>
In-Reply-To: <ZIIAPz/HOqPXjKIs@redhat.com>
References: <167305907804.10652.2746409341903316717-1@git.sr.ht>
 <d2850ef0-d825-bb03-09d4-0d1427cf6577@ilande.co.uk>
 <20230123200937.32eb19eb.hc981@poolhem.se>
 <20230304220754.0c6ae562.hc981@poolhem.se>
 <ZCLzUyiDeKLfQqWT@redhat.com>
 <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
 <ZIIAPz/HOqPXjKIs@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=2a0b:dc80:cafe:112::1;
 envelope-from=hc981@poolhem.se; helo=mailout12.inleed.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On Thu, 8 Jun 2023 17:22:23 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Sun, Apr 30, 2023 at 10:55:33PM +0200, Henrik Carlqvist wrote:
> > What is the best way to document this kind of global parameters?
>=20
> You can put it in docs/system/sparc.rst (or sparc64.rst whichever is best=
?)

Thanks for your reply! As far as I know those dip switches are only in the
keyboards of the old 32 bit sparc machines, ultrasparc used USB keyboards
instead without any dip switches. I will add the text to
docs/system/target-sparc.rst.

Would you like the documentation as a separate patch or added to the patch
which adds the functionality to hw/char/escc.c?

I hope to be able to create the patch in the upcoming weekend.

Best regards Henrik


