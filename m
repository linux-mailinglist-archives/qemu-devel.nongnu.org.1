Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E71AA7B7E09
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzsp-0002NJ-Tj; Wed, 04 Oct 2023 07:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnzsn-0002N9-5m
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnzsl-0000S5-MV
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696418255;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=8aSW0CUZxxTT/lXw42wJrQ1P4gVVQOu2bWBEHnho/k8=;
 b=MXJWmbjWJRvVmMf1JF7Gyi3dAJ2rWqIPfcEGSIHYatMJhP4iE5OOdrcA+TVyIPU5OZ4CvF
 naAXJEP0Qs9YT8rqo1oQX/idc1MohyyDhb6kCs5Qr2T9KSwRqgQG4fpVBKeWlC/DSl/yL0
 5i6GroVxExh7G/901E3SJ8l7XJRxzsM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-LlYeLfNpOs6VtndWOPqm9A-1; Wed, 04 Oct 2023 07:17:33 -0400
X-MC-Unique: LlYeLfNpOs6VtndWOPqm9A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40647c6f71dso15120035e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 04:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696418252; x=1697023052;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8aSW0CUZxxTT/lXw42wJrQ1P4gVVQOu2bWBEHnho/k8=;
 b=iUjwL997wz41xJ2SG6l+/nmFToduSzkyRxK6gFPyhWsAIkyNSLOfj3y3FQhnJArsBZ
 6pltRrwqIxEZ+kHM6tt1OBGsZNHf1v5cOSXfNnsPBlIRGTIxD5wpOLELraKrv6Igoo/J
 OPPNOPIwlLt/rPvc/dbbL7IBgtv10gLU9JYvhFl5qm/Z9eVA8aOrlYAm2a1spwkoKL7m
 jGx4ihHoI9ZSWIiLCYI3ZLTMcEaQnoxw8iDRCE9Nrneeoa98UBTg7kaZLbaIOjm0D/nx
 Np8y4KyHd/TSKcNMATYMnbihvbVzvYwpasK4DzrT/WKVFBWvPQPDNmueUB/1O9gyjs6v
 xRmw==
X-Gm-Message-State: AOJu0Yyu6Is/7p9ThKyGGLblz0WYQ5LyHRDdJ77NQgKS8nwxtf/yrkOK
 B1lEVh8rjzfZkN+H5KGiLqxcesXK6n50tWZnoLD6NaOc+KTvljX++6110uOr1WZg7olhTXDfMqb
 gyU2+LGgyxUWJHxE=
X-Received: by 2002:a7b:c456:0:b0:402:eab3:b4e9 with SMTP id
 l22-20020a7bc456000000b00402eab3b4e9mr2153728wmi.33.1696418252710; 
 Wed, 04 Oct 2023 04:17:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5S05dzTTPeadp4shxR/3zytu5TSMiHEp+O0rgY8bydrvjfXZiZXjYRnmVv5yZP3/yI+kH9w==
X-Received: by 2002:a7b:c456:0:b0:402:eab3:b4e9 with SMTP id
 l22-20020a7bc456000000b00402eab3b4e9mr2153667wmi.33.1696418251447; 
 Wed, 04 Oct 2023 04:17:31 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m7-20020a05600c280700b00405391f485fsm1249643wmb.41.2023.10.04.04.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 04:17:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH V5 2/2] migration: file URI offset
In-Reply-To: <1694182931-61390-3-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Fri, 8 Sep 2023 07:22:11 -0700")
References: <1694182931-61390-1-git-send-email-steven.sistare@oracle.com>
 <1694182931-61390-3-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 13:17:30 +0200
Message-ID: <87bkde4oxh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Steve Sistare <steven.sistare@oracle.com> wrote:
> Allow an offset option to be specified as part of the file URI, in
> the form "file:filename,offset=offset", where offset accepts the common
> size suffixes, or the 0x prefix, but not both.  Migration data is written
> to and read from the file starting at offset.  If unspecified, it defaults
> to 0.
>
> This is needed by libvirt to store its own data at the head of the file.
>
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


queued.


