Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A06FF7B2032
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 16:53:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlsMz-00008Z-JA; Thu, 28 Sep 2023 10:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlsMy-00008P-DI
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlsMw-0006Df-Ai
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695912716;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hcUNXT/qN4xNM45zJdcwPrcco40O2wscmSCxcFGwuro=;
 b=Cri7aib++VAjPONyv8r+jpm0oln9x8yGY3tbQfy0Lwa68nM35vDBrIwiHc074mTpWUK2MT
 ODF9a7TvrQxgo5galkrWRCfCrZ2e+7Wg5nDtn/ZNqm4ZXn0nQxtBe6pB8dZNOymrIhPS51
 4b1S+ARuYxxtPNLASF2lr3KXJNKKJro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-RY5VHruKMQGPwzXtkgMyBQ-1; Thu, 28 Sep 2023 10:51:54 -0400
X-MC-Unique: RY5VHruKMQGPwzXtkgMyBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C43BB101A53B
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:51:53 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0845F400E89;
 Thu, 28 Sep 2023 14:51:52 +0000 (UTC)
Date: Thu, 28 Sep 2023 15:51:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 2/9] qapi: golang: Generate qapi's alternate types in Go
Message-ID: <ZRWTBpWn4m3rrGMZ@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-3-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927112544.85011-3-victortoso@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 27, 2023 at 01:25:37PM +0200, Victor Toso wrote:
> This patch handles QAPI alternate types and generates data structures
> in Go that handles it.

This file (and most others) needs some imports added.
I found the following to be required in order to
actually compile this:

alternates.go:import (
alternates.go-	"encoding/json"
alternates.go-	"errors"
alternates.go-	"fmt"
alternates.go-)


commands.go:import (
commands.go-	"encoding/json"
commands.go-	"errors"
commands.go-	"fmt"
commands.go-)


events.go:import (
events.go-	"encoding/json"
events.go-	"errors"
events.go-	"fmt"
events.go-)


helpers.go:import (
helpers.go-	"encoding/json"
helpers.go-	"fmt"
helpers.go-	"strings"
helpers.go-)


structs.go:import (
structs.go-	"encoding/json"
structs.go-)


unions.go:import (
unions.go-	"encoding/json"
unions.go-	"errors"
unions.go-	"fmt"
unions.go-)




With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


