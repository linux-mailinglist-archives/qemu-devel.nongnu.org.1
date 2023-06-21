Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F12E73869C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:17:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBydi-0005xz-Jn; Wed, 21 Jun 2023 10:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qBydg-0005xY-F2
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:16:52 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qByde-000402-B8
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Cc:
 Content-ID:Content-Description;
 bh=eaJmqR6up6YsWmQDZkJPcCoGIjICd/lH5f9KCDMiQRo=; b=H/T4rLnxnFusZEcFznwzLeTpGe
 UvcJ5eWALZJncleog4LJr6COi9LE1fJmddJ9+Hqw1YU2Mx3OYIVBYlqk8pfSS+RYxujxp5Nume74o
 wBzGPRKn8wo2JXeWgyNjI3PG2Vz0wwmoxdy29Um3ymnVwyzY/SjORcfKEXL5sSS3b/OXfLHzHI38u
 36sgekFZeJ0JGM+v0UKWZexJGgdBakrxD4Yk9xhMMsipUEevIDcImy0pY3MR5COoF+daMicFMF0hi
 GWQgH8wkepOLuDbuewyyJzTcJaRpliSmCJZXNGVI8+AeV/VBx9gfYqUpVywRksNx3vXPVuTJx4OHY
 jtnXTi05G2t77Wn/OL43Qz9hHHt5ZQn563rRSLjDq2nI4fkmaY8hU5iCJraXiRXNnL/PFoAxVxA41
 5v7aYal252xrbUlcaLaYgJbxkCeJF+HDJYX38AsfzsXZl92pI1cr0WuG/glnNlwVzNrtBUqwNcR9h
 DzIDvUxCYzxQrtammRULMoyp7rpHQ9GxQQSLUiNYAV9agOY0WTuVjd9z/QYQ+pMLjOULSkwCjslZn
 kKZ53pSZbN5/+1QTztTmBi1orTJxkbIVE76BBywqLtyALnYbmjlmZ81baJSTuNXSRcwSvlDw3PQVZ
 kqwYYEnSX9+vztN8/kZt2j7SgFjLQnPcIKFggVzQk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3] 9pfs: deprecate 'proxy' backend
Date: Wed, 21 Jun 2023 16:16:46 +0200
Message-ID: <1802263.gKGKeHe8zJ@silver>
In-Reply-To: <20230621154136.6e1f3f4b@bahia>
References: <E1q7ytt-0005Fl-JX@lizzy.crudebyte.com>
 <10417219.URJpt1F07l@silver> <20230621154136.6e1f3f4b@bahia>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wednesday, June 21, 2023 3:41:36 PM CEST Greg Kurz wrote:
> On Wed, 21 Jun 2023 15:32:39 +0200
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > On Thursday, June 15, 2023 11:35:05 AM CEST Christian Schoenebeck wrote:
> > > On Saturday, June 10, 2023 3:39:44 PM CEST Christian Schoenebeck wrote:
> > > > As recent CVE-2023-2861 once again showed, the 9p 'proxy' fs driver is 
in
> > > > bad shape. Using the 'proxy' backend was already discouraged for 
safety
> > > > reasons before and we recommended to use the 'local' backend instead,
> > > > but now it is time to officially deprecate the 'proxy' backend.
> > > > 
> > > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > 
> > Ping
> > 
> 
> It seems you missed the review I posted last week :
> 
> https://patchew.org/QEMU/E1q7ytt-0005Fl-JX@lizzy.crudebyte.com/
#20230612165742.3333ea08@bahia

Oh, I never received your email. I'll check the logs what happened there.

I'll send a v4 with your suggestions, they make sense.

Do you want me to add your "for the records" comments as well in the
deprecation notice?

Best regards,
Christian Schoenebeck



