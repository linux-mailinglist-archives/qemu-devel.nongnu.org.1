Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F121E77D5DF
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2Qf-0007aw-AP; Tue, 15 Aug 2023 18:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2Qd-0007am-N1
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2Qb-0001UU-Gj
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692138136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/zOkUNvUjVkCxNZByZcA/SYYHv1Q44qV+S1KXAUgmE=;
 b=Ed9dlxUgC81JpaxI2zjYHcmjDY2R4RqxVZQchZd7efF0FNsMm/Zi1Q+CaOV8SH3BwJMxze
 uf5e7uII1ZoX0ou8EuWE/x9SJN/M0nDR/Bdryl1xxODfZMakJzEjht+98avCoRbl9ZCBkq
 CJL7/SZsZJwwh8bWtZ4aX05mWoIlys8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-9FcT3IPRM7abEt-GJkfaCQ-1; Tue, 15 Aug 2023 18:22:15 -0400
X-MC-Unique: 9FcT3IPRM7abEt-GJkfaCQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76ca3baaec8so159645885a.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692138135; x=1692742935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/zOkUNvUjVkCxNZByZcA/SYYHv1Q44qV+S1KXAUgmE=;
 b=EGr4rDm8RN5JvH6DlucNSMLI+LFn520XtR2fYi36zT8UxCYLNgNvW+KRTroWJSGl5T
 ztuuZZAphJ8ak8x5V5C/We4Xd+ySH0L0pDEcTOepduTpM7CXMX+YpE73yvslddO7ZRVC
 68meyx7FCAA4hEy2Sgzb/cGaT0UPlxmg2zrupCM0Qd8f1zwIqhQqDHMShkuH77CLu7XN
 xmGuSiFHZwrdtHISQ9hoBHyFSNEPB/9ZGBJnsSfdF1KbjTFxWWCLsdBxJ3j28j8PoSuC
 UWVT8G4LXhxtlWbFA2a3epC+4eVAwJUVrueuwSDGt3LvcUFxSNdQNvEsDzqryAnq8rOW
 GeIA==
X-Gm-Message-State: AOJu0Ywjmwk03qR4+J2R8XIctkFEMjvaqt4Ik5SxDCo6gKhVpLbqrBJq
 wz6wlQ6qbyly2JtXG0wjXfJHgLgtei3rPplOB6EqeyRADmvXUdrv7syWu2DDS7D5URPp+i6qrLj
 Q3n2jbNHIJ4uASSI=
X-Received: by 2002:a05:622a:19a2:b0:3f6:a8e2:127b with SMTP id
 u34-20020a05622a19a200b003f6a8e2127bmr71879qtc.5.1692138134959; 
 Tue, 15 Aug 2023 15:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/nnO//1pIlhGpxIfnY11DbQMMmXm+C+NWzYUE6uFuviZ0z4Jp3IZBBdsKnnMlgatva7hTNg==
X-Received: by 2002:a05:622a:19a2:b0:3f6:a8e2:127b with SMTP id
 u34-20020a05622a19a200b003f6a8e2127bmr71861qtc.5.1692138134675; 
 Tue, 15 Aug 2023 15:22:14 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 e12-20020ac8064c000000b0040ff121e011sm4075253qth.2.2023.08.15.15.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:22:14 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:22:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/5] migration/ram: Stop passing QEMUFile around in
 save_zero_page
Message-ID: <ZNv6jwMBfVndibEE@x1n>
References: <20230815143828.15436-1-farosas@suse.de>
 <20230815143828.15436-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230815143828.15436-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

On Tue, Aug 15, 2023 at 11:38:25AM -0300, Fabiano Rosas wrote:
> We don't need the QEMUFile when we're already passing the
> PageSearchStatus.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


