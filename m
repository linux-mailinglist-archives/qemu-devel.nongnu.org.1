Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3305E7B9F0E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoP9O-00053z-05; Thu, 05 Oct 2023 10:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qoP97-00050h-Sy
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qoP96-00087J-Bk
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696515365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yKvbXZq4T+rz3iviuGeoBuaGaO2BmegjbTMS0pcAycc=;
 b=XoJ/kMJ6Fj6bx3rjsv9gUexcU6i95qswsh6hQg6tvR1gSoaKTeNN0yY5sXWg981pBL3dKf
 ZN7t+e8gnUBWxR//rjTipeKd/6AoB5ey/DPNxtl6XfxMhqlJWPgG4NLTex9r2/HZVtdSiG
 hUqb6OqZREi/9q+9RFKKyNmMzZ9zi9E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-P7ciWIkqNNSmLCaMvXr_Ng-1; Thu, 05 Oct 2023 10:16:04 -0400
X-MC-Unique: P7ciWIkqNNSmLCaMvXr_Ng-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED11A801E91
 for <qemu-devel@nongnu.org>; Thu,  5 Oct 2023 14:16:03 +0000 (UTC)
Received: from [10.39.194.153] (unknown [10.39.194.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B24492C37;
 Thu,  5 Oct 2023 14:16:02 +0000 (UTC)
Message-ID: <0bdd14ac-2964-1da1-716f-7aa69e773129@redhat.com>
Date: Thu, 5 Oct 2023 16:16:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] WIP: ramfb: migration support
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com
References: <20231005113027.1827078-1-marcandre.lureau@redhat.com>
 <2907c142-13c1-01ad-f603-e39983d65859@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <2907c142-13c1-01ad-f603-e39983d65859@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
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

On 10/5/23 14:01, Cédric Le Goater wrote:
> On 10/5/23 13:30, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Hi,
>>
>> Implement RAMFB migration, and add properties to enable it only on >= 8.2
>> machines, + a few related cleanups.
>>
>> Cedric, did you get the chance to test the VFIO display/ramfb code?
> 
> Nope. I was busy with VFIO stuff. I haven't even read Laszlo's
> email yet. I will try this or next week.
> 
> That said, could we avoid adding another migration property in
> VFIOPCIDevice and use the available "enable-migration" ?

I'm not entirely sure, but I suspect we can't / shouldn't do that.
"x-ramfb-migrate" is effectively a machine type compat prop, so if it
doesn't *precisely* line up with enable-migration (i.e., if they aren't
equivalent), then we shouldn't merge them. AFAICT, a 8.1 machine type
may have "enable-migration" set, but it should still have
"x-ramfb-migrate" clear.

Laszlo


