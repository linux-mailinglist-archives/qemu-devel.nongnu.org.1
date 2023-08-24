Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA06786AD9
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 10:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6AJ-0007Iw-Ja; Thu, 24 Aug 2023 04:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AH-0007Dq-8O
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qZ6AF-0003hh-3m
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 04:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692867481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+y/udKsUMGkvnay5hfB5m0/3lZZsX71kSLYfxOUoJcI=;
 b=d0p0O4YQlcH45LPCbsAkh+ZnlsjspAekb1tiMcKm0KT3G2/D9+hf6Ht3k0+Vz3xnPJk9d7
 KzvI0Kx0pLNFlQJh8hbaX1PLuH955nJnfeWsvP87Jsfkkt2VjUdvPp3zsNOrN2uRN/aydy
 81wdaAIm9gXIMgdKbDK3SAFw9ouw+/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-TdjrF6jmMy-nGbqbcdt5iw-1; Thu, 24 Aug 2023 04:56:07 -0400
X-MC-Unique: TdjrF6jmMy-nGbqbcdt5iw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99856853069;
 Thu, 24 Aug 2023 08:56:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC5D40C6F4C;
 Thu, 24 Aug 2023 08:56:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 13FA618003AB; Thu, 24 Aug 2023 10:56:05 +0200 (CEST)
Date: Thu, 24 Aug 2023 10:56:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "seabios@seabios.org" <seabios@seabios.org>, 
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Subject: Re: [SeaBIOS] new release tag?
Message-ID: <ifi2dswo3cuqquzqiys7jamlvefaoxmvobljqotrh63xzceld6@ndbqfrnp762a>
References: <ZNDMtAeAGJardllS@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNDMtAeAGJardllS@x1-carbon>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 07, 2023 at 10:51:33AM +0000, Niklas Cassel via SeaBIOS wrote:
> Hello Seabios maintainers,
> 
> 
> I was wondering, is there any chance of getting a new release tag
> (e.g. rel-1.16.3) anytime soon?
> Or is there any plan on when it will be tagged?
> 
> I'm waiting to send out a (AHCI specific) QEMU patch, but I can't
> do so until:
> 1) there is a new Seabios tag
> 2) QEMU has updated to the latest Seabios release tag

I guess Mark (Cc'ed) is sitting in the same boat with the scsi
driver fixes.

We just missed qemu 8.1, so we don't have to rush things,
but it probably makes sense to update seabios not too late
in the 8.2 devel cycle due to qemu patches depending on the
seabios fixes.

Cc'ing qemu-devel: Are there any qemu changes pending or
planned for 8.2 which need changes in seabios?

take care,
  Gerd


