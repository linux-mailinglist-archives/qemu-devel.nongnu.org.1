Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3FB7986FB
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaZ4-00040B-S8; Fri, 08 Sep 2023 08:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeaZ2-0003vI-Ag
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeaYy-0007lN-Sl
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694175976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5nuETMLzCmtMCNwvivllkCcNWiiVU6hf4rdBB3xRCo=;
 b=fByr+a1eZCLbTCMzXTJGVS46nyJR+xX0MfMbYZ7jaeAAIB5uNIozSBeRAiXJJ7WBKwi/sP
 IlfWfyUNQGk2b+mVGom8OgEufvJtOmP5OMX9HTWYZTQEq9B763rNpzBl42siZHSyFMXzR+
 cb2zz/aKS31sKpiGgI7gK2Aa/X87Pvo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-4aMLSIQUMjWVNxvcoK9TuQ-1; Fri, 08 Sep 2023 08:26:14 -0400
X-MC-Unique: 4aMLSIQUMjWVNxvcoK9TuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5372A3815EF2;
 Fri,  8 Sep 2023 12:26:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AE6D2026D2B;
 Fri,  8 Sep 2023 12:26:13 +0000 (UTC)
Date: Fri, 8 Sep 2023 14:26:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw: forbid DEFINE_PROP_ARRAY for user creatable devices
Message-ID: <ZPsS5BHFNhZDDHJC@redhat.com>
References: <20230908092951.2683721-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230908092951.2683721-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 08.09.2023 um 11:29 hat Daniel P. Berrangé geschrieben:
> The DEFINE_PROP_ARRAY macro is a clever trick for defining array
> properties. It initially creates a property "len-$FOO". When that
> property is set, then it creates a sequence "$FOO[NN]" for NN
> in the range 0 to "len-$FOO".
> 
> The intended usage for this was to simplify code for internal
> devices, however, it crept into use for user creatable devices
> when the 'rocker' network device used it.
> 
> This relied on the user specifying the len property first on
> the -device comand line, and the args being processed in-order.
> The latter was broken[1] when -device was converted from QemuOpts
> to QDict[2], as ordering of loading properties was no longer
> guaranteed to match user specified ordering.
> 
> This change poisons the setter for "len-$FOO" such that it raises
> an error when used with a user creatable device.
> 
> This allows DEFINE_PROP_ARRAY to remain exclusively for internal
> devices, since code can ensure properties are set in the correct
> ordering.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/issues/1090
> [2] f3558b1b763683bb877f7dd5b282469cdadc65c3
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

NACK.

This doesn't fix the problem, but breaks rocker for good. As I said, I'm
working on proper array support and will send patches soon.

Kevin


