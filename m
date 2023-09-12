Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CD979CE97
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:42:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0pw-0006r6-OY; Tue, 12 Sep 2023 06:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qg0pu-0006oj-VU
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qg0ps-0001ZB-Li
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y4UDEBU2/j/NIFEK0uMXoW4TDBq43+2dLxTJrOIP4N8=;
 b=a4/pKn+LOFUG6g4Cn+LngdINA2SbFiDUtdwekidv9jyfRuR78QfK4/OFR57HQEkQBP8+oI
 PAm05xbIPuSfdwg9ByBARqW1eLpNdV9Fvj5cENWXaBWj2zpSnBn0Mab6YT5AdCiH1J/oDh
 Kr4Suyu/ewZUnc93LX7/FxY4xsAuQh8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-f6BcblA1PCygGm6ZzJHhag-1; Tue, 12 Sep 2023 06:41:28 -0400
X-MC-Unique: f6BcblA1PCygGm6ZzJHhag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33C1B38117FE;
 Tue, 12 Sep 2023 10:41:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDC2121B2413;
 Tue, 12 Sep 2023 10:41:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8AE001800097; Tue, 12 Sep 2023 12:41:26 +0200 (CEST)
Date: Tue, 12 Sep 2023 12:41:26 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "seabios@seabios.org" <seabios@seabios.org>, 
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [SeaBIOS] Re: new release tag?
Message-ID: <vyywzh43z2fh2rybfgka6sv35hghzc4qpfyvbtc7ruhtlp3mlb@uqtjzwrw2u2v>
References: <ZNDMtAeAGJardllS@x1-carbon>
 <ifi2dswo3cuqquzqiys7jamlvefaoxmvobljqotrh63xzceld6@ndbqfrnp762a>
 <ZPrwOo6KVPk7N6yq@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPrwOo6KVPk7N6yq@x1-carbon>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Hi,

> > Cc'ing qemu-devel: Are there any qemu changes pending or
> > planned for 8.2 which need changes in seabios?

/me notes that nobody raised his hand.

> Hello Gerd,
> 
> The QEMU 8.2 devel cycle has started.
> 
> I do not want to stress you, but if we want to get additional fixes in,
> that depend on the new seabios version, isn't it better to get the new
> seabios version included sooner rather than later?

Yep.  I think I'll go with a git snapshot for now, to give the current
seabios master some more testing coverage before tagging a release.

take care,
  Gerd


