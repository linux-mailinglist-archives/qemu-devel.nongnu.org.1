Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C52BC738BD9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:45:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0wj-00047F-Cr; Wed, 21 Jun 2023 12:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qC0wg-00046o-Pl
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:44:38 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qC0wf-0004bq-3V
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=/DXP2WjYDMVfh8WPRC7tcGAjJCuNxzny85+VRNGWxec=; b=LWGqGvsllHHH6WcW+S8mswZ2jD
 lneWbgqjyHDTn8jvrseSIxoQfHz+y2bRlXRierdw6WW691K3QyDddYQzK/5CY7gA2Q2jEte4JfKPp
 ZhXYLxx8vjRzkdoU7WnpTEwTodq5evhD9MuGeC9j+AHbPMpa4BbVy1Chggoe+kAS1XHwDJdLSPEzd
 b+j8ffqtppK6HiQwKIeHBO/MUO1PIEWOeUiJf7KOxKyN6slEQzzkKK9WJBcsKhKGHRbhKLD+OeGnU
 H34tOV05QKPt5KmokZDJo2sV4iOWexILyBMLgO8MPS8Wzd1hwKXHlJP/XVMhqWAv8KhEyeNY3J/CM
 CeKgMNqpbirGGeNC0JPnvO6YTnXTT9WIawOM1bT2G9jca30ZVyVRjyDgU7RcNRc2rAU9HdhmhC4ty
 Jci8O0WeaF0uygt+5lRgZ1duEh22sYdGTrLWVRCR4HG3J96KVXQB4KtvkJHF/4UXvUP7W9lJJh3Sw
 iG9MUHghFOb/RLVX5wAHyUkmSQ39dVMUJRqiybBDTvsPu5Udz7capkR6PqE8EmTvd4P4zqw0vxftU
 yyu/B0TuzHPn3evkhjisXCZcw2Ju6SClpWvx7vB5VUXRDf9n+a0haEx5t3BqDstJAtNbpFP/+WurA
 JS+/3mHQ5oSYcvaD7i1eex1j1pOzdMwGVgCG8ElKE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3] 9pfs: deprecate 'proxy' backend
Date: Wed, 21 Jun 2023 18:44:33 +0200
Message-ID: <4339157.nmqpxYUvy1@silver>
In-Reply-To: <ZJMXIajM3y6BSPlm@redhat.com>
References: <E1q7ytt-0005Fl-JX@lizzy.crudebyte.com>
 <54432347.sjJ5l9EzYk@silver> <ZJMXIajM3y6BSPlm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

On Wednesday, June 21, 2023 5:28:33 PM CEST Daniel P. Berrang=E9 wrote:
[...]
> > > I'm fine with deprecating this. In terms of messaging wrt replacement=
s,
> > > we should highlight both the 9p 'local' backend, and virtiofsd as the
> > > two alternatives. The latter is likely the better choice (on linux
> > > hosts) for many.
> >=20
> > OK, I can add that to the deprecation doc, but you don't want that to be
> > added to all the runtime warnings as well, do you?
>=20
> I'd suggest we could do mention it briefly as an option at rutime, eg
>=20
> warn_report("'-virtfs proxy' is deprecated, use '-virtfs local' or virtio=
fs instead");

I asked because with what Greg already suggested, it starts to become a long
runtime message, like:

  "'-fsdev proxy' and '-virtfs proxy' are deprecated, use 'local' instead of
   'proxy' or virtiofs"

And that's probably still ambiguous, becauses that might suggest people that
they could simply s/-virtfs proxy/-virtfs virtiofs/.

Low care rate on my end though.

Best regards,
Christian Schoenebeck



