Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB82C822E07
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 14:11:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL10g-0003xQ-9Q; Wed, 03 Jan 2024 08:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rL10e-0003xH-Iv
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:10:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rL10c-0003te-U3
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704287409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2CuiQoBk2YXzg3hA1nNLqJn9zpXcwn+jZFot9rG/Ds=;
 b=YwcdtW3it1y27qCzibuJIvWi3PjNK0SEUZE4CglbxdiPv7sD7vzvpq4MB7JIGsgVR1+VIJ
 cYfrOuzDIBHsc+4HNisllYkpi3+RRLMqC7nW3kCAJ8QGAXq10oenJwXUgALoPQRJxHY/XG
 2l7Gx/ZHMjGMvFSsrKOjNd+lygH4928=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-psRmLB5nMv-9BSktKEgVIQ-1; Wed, 03 Jan 2024 08:10:08 -0500
X-MC-Unique: psRmLB5nMv-9BSktKEgVIQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d99a379dacso1688967b3a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 05:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704287407; x=1704892207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2CuiQoBk2YXzg3hA1nNLqJn9zpXcwn+jZFot9rG/Ds=;
 b=xG3c3ZIV1BtcO9dH917KN3znG+vO7qqy1uwHgaLI36mIvsPb2eYURfdFtOFgGF7aO6
 lkWQ8UVh+I3XwXhQba7djuXDl2qV5OpzgfZLYeH9uvgNAiK7iUE130yQPJXFv+6cr9oZ
 keYzjcIxjGEKrKieVLmt6BVqpRndXXzqOKVOIFO2Spzmng2459627uTwf50ogZU8pDad
 fuxCAfPn9RIpiybG9g/Usap8QZGXYCwAkB6wA++hfHVEh5wCITySAz04I6xEg4HjfroH
 20M/4u3qle5QI7viiFPhfsvphXEAwd7DA72kt8MOdvZ4/pWtBUCf37UmpbLmBVYUKwBp
 IQhQ==
X-Gm-Message-State: AOJu0Yx6IUNEJCXQX0g80CdbN7bSFzGbFiPLDal9tN08ZzIWMXEMnU1i
 aiC84xYIWo4/D4ChVR6RNXs4/kTHnwOcwAjQPHB8RWsmnB2n3aRFzsUR5rJep6G8XAoRfGduad1
 D2XQepCQqMcdditch3psAVho=
X-Received: by 2002:a05:6a00:658d:b0:6d9:edd1:4ede with SMTP id
 hd13-20020a056a00658d00b006d9edd14edemr22641975pfb.2.1704287407395; 
 Wed, 03 Jan 2024 05:10:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdoPKDppXa7FhUJIUizdWp1YaxoG1/jJuH+nOKKwi7ARD5LqJ3NGAt6oTN6R4ROrBhLhHNsA==
X-Received: by 2002:a05:6a00:658d:b0:6d9:edd1:4ede with SMTP id
 hd13-20020a056a00658d00b006d9edd14edemr22641956pfb.2.1704287407018; 
 Wed, 03 Jan 2024 05:10:07 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 x37-20020a056a000be500b006d9c16b2089sm15937061pfu.188.2024.01.03.05.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 05:10:06 -0800 (PST)
Date: Wed, 3 Jan 2024 21:09:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 Steven Sistare <steven.sistare@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
Message-ID: <ZZVcpG8j4qrEYCvS@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
 <87bkaiig2s.fsf@pond.sub.org>
 <9d613137-24aa-4323-aee1-0d38b91339c5@oracle.com>
 <87sf3ta31i.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sf3ta31i.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

Steven,

The discussions seem to still apply to the latest.  Do you plan to post a
new version, with everything covered?

Thanks,

-- 
Peter Xu


