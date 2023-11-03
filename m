Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4A7E02F6
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 13:33:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qytLn-0008Cx-Ul; Fri, 03 Nov 2023 08:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qytLk-0008Cl-K4
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qytLf-00038N-RS
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699014746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r0hliWXR/wDjE88eQ470ouuzIUzMvzd0ILVY4qo6cVs=;
 b=f1+kywkajV8Uvv/w498E4/F5jlkMtYhL9dl2Ti5rl/jfqCOU4cqWy7Zhg/V/K2JRA9ySqs
 9H0Fg+oTWBnZbG06flkqps1cendQPcgwGismxag7fQSEcFoQdomGY4imhCsNVrJKzJ0ICl
 t99LD1JIvAKyYNDc2WcrS/8JXt5PVFs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-H-gzC3y9MfWXlwuvfKTaug-1; Fri, 03 Nov 2023 08:32:23 -0400
X-MC-Unique: H-gzC3y9MfWXlwuvfKTaug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE1AF85A59D;
 Fri,  3 Nov 2023 12:32:22 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A02EC492BE0;
 Fri,  3 Nov 2023 12:32:21 +0000 (UTC)
Date: Fri, 3 Nov 2023 07:32:19 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 12/12] qdev: Rework array properties based on list
 visitor
Message-ID: <4qjmbspladtbvyusklkk6hyz54azlcuxwpleskzardyyd5k35q@mmtrmcaemhrl>
References: <20231030142658.182193-1-kwolf@redhat.com>
 <20231030142658.182193-13-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030142658.182193-13-kwolf@redhat.com>
User-Agent: NeoMutt/20231023
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Oct 30, 2023 at 03:26:58PM +0100, Kevin Wolf wrote:
> Until now, array properties are actually implemented with a hack that
> uses multiple properties on the QOM level: a static "foo-len" property
> and after it is set, dynamically created "foo[i]" properties.
> 
> In external interfaces (-device on the command line and device_add in
> QMP), this interface was broken by commit f3558b1b ('qdev: Base object
> creation on QDict rather than QemuOpts') because QDicts are unordered
> and therefore it could happen that QEMU tried to set the indexed
> properties before setting the length, which fails and effectively makes
> array properties inaccessible. In particular, this affects the 'ports'
> property of the 'rocker' device, which used to be configured like this:
> 
> -device rocker,len-ports=2,ports[0]=dev0,ports[1]=dev1

If you tweak the commit message, you might also want to mention that
this form is a shell-glob deathtrap (if you are unlucky enough to have
a file named rocker,len-ports=2,ports0=dev0,ports1=dev1 in the current
directory), and therefore should have used shell quoting...

> 
> This patch reworks the external interface so that instead of using a
> separate top-level property for the length and for each element, we use
> a single true array property that accepts a list value. In the external
> interfaces, this is naturally expressed as a JSON list and makes array
> properties accessible again. The new syntax looks like this:
> 
> -device '{"driver":"rocker","ports":["dev0","dev1"]}'

...at which point, the fact that you HAVE to use shell quoting to get
JSON through the command line is less onerous than if the older syntax
had been safe without quotes.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


