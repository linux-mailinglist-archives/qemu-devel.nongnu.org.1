Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB11836B5C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 17:43:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxNu-0007pH-JA; Mon, 22 Jan 2024 11:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rRxNs-0007oT-GT
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rRxNq-0002eP-ON
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 11:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705941769;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=45MOSeBQTvIeRIII9W6u6TvlETuhZbzs7YESXmxYZlk=;
 b=BEjKv0SjeMA48Aqu612U8rOJb55XiTpqqcL+3pIDiy/QOmVVR3uxDOYVoqLBSEqrfJi1sv
 yErpS4ITvgqAEd+k2+F8M91sGSgOv61ysRy7lxZpmUDkdRJouXP7gxfDSZKQUsn06Tjyl/
 +knzfDHtYBfApzEA05fC/hIVa8qp2+Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-OdmVLVMiOi-g-nJIsBx_IA-1; Mon,
 22 Jan 2024 11:42:48 -0500
X-MC-Unique: OdmVLVMiOi-g-nJIsBx_IA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACB241C04182;
 Mon, 22 Jan 2024 16:42:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88C251121306;
 Mon, 22 Jan 2024 16:42:46 +0000 (UTC)
Date: Mon, 22 Jan 2024 16:42:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Bohdan Kostiv <bogdan.kostiv@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/2] system/vl.c: Fix handling of '-serial none -serial
 something'
Message-ID: <Za6bBP0LP490UPf8@redhat.com>
References: <20240122163607.459769-1-peter.maydell@linaro.org>
 <20240122163607.459769-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122163607.459769-2-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jan 22, 2024 at 04:36:06PM +0000, Peter Maydell wrote:
> Currently if the user passes multiple -serial options on the command
> line, we mostly treat those as applying to the different serial
> devices in order, so that for example
>  -serial stdio -serial file:filename
> will connect the first serial port to stdio and the second to the
> named file.
> 
> The exception to this is the '-serial none' serial device type.  This
> means "don't allocate this serial device", but a bug means that
> following -serial options are not correctly handled, so that
>  -serial none -serial stdio
> has the unexpected effect that stdio is connected to the first serial
> port, not the second.
> 
> This is a very long-standing bug that dates back at least as far as
> commit 998bbd74b9d81 from 2009.
> 
> Make the 'none' serial type move forward in the indexing of serial
> devices like all the other serial types, so that any subsequent
> -serial options are correctly handled.
> 
> Note that if your commandline mistakenly had a '-serial none' that
> was being overridden by a following '-serial something' option, you
> should delete the unnecessary '-serial none'.  This will give you the
> same behaviour as before, on QEMU versions both with and without this
> bug fix.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Bohdan Kostiv <bohdan.kostiv@tii.ae>
> Fixes: 998bbd74b9d81 ("default devices: core code & serial lines")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> See the discussion of Bohdan's patch on the mailing list for
> further context:
> https://lore.kernel.org/qemu-devel/CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com/
> ---
>  system/vl.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


