Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 569B57A6890
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:04:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidBc-0003ES-U0; Tue, 19 Sep 2023 12:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qidBM-0003BR-3z
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qidBH-0002Nq-0P
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695139349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7cvqwtsgvbxEAPpwTJ0MFVJJxwtgSOCf6HW1RIjUxo=;
 b=B82mlCm6sUuSey+Ygog6Gqqv2glzwdSh9R6bbLxWEhavIi+jcEHR9ayneAyPbtdVqvVnqP
 Y4AUzgK0KDvzWP2tTMCMDG2911a5azSntJOaREUbNRvJafOX2LRQNtUdKmftLOTBZKDIyP
 k/3ZT/h4RIoq+drzFDIJ7vRoqcxRMB0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-QACNQWogNIuq6v_w0HQUzQ-1; Tue, 19 Sep 2023 12:02:28 -0400
X-MC-Unique: QACNQWogNIuq6v_w0HQUzQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-637948b24bdso16584586d6.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695139347; x=1695744147;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7cvqwtsgvbxEAPpwTJ0MFVJJxwtgSOCf6HW1RIjUxo=;
 b=fNtt2TJlrB4O9gmO/nG8hj41MNtUxLlUHW5onXL/jL1Ny551u4Vqn4V/WQ1YbvFyNu
 ZRcXVE3Of/0whKNI0Z+inOR3s5YfBTzB40CDNOAl11d+uOqBU6uJv3gw13486J4/yQQ2
 RM5JBFg5VuCBbcbbspzG+aQkcm2noCKDiGTqN4txRNWVNtk0+z1t+HyrUHJBVB42WKx4
 03LUAjCQAdErvkdH2axmiB2bbTPq3geiJLbwDAtmRUNC86DOFeIh4czMbj1uvmp9SiJm
 s87KsITa0A/1HtnBt/tgcnpnRA9VaiAXuHDH0fpar6TB+ljS8If6vpgXcJ0jy0fd69OE
 k/nA==
X-Gm-Message-State: AOJu0YwnaVJa1KJHZoc3Wu9Y0lUyLcsHNdptLgfpS2/mleteGqs4Exhg
 Rs9cs2lNSr2uYjj458d0fvugZjHxfjdIUTdRYUUd6cYMtBxvCxk46OeK1DrUnvKZEFSry+fuJjD
 P0D1m+Yv6YbV3xYU=
X-Received: by 2002:ad4:4191:0:b0:658:3608:28e0 with SMTP id
 e17-20020ad44191000000b00658360828e0mr4134792qvp.1.1695139347675; 
 Tue, 19 Sep 2023 09:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaujb3sxCeXXurGATRF0TzOgODOupnSqVRgTmh5uFE1A+wUkcYgTOuqGqSNKAokIg8q48+/Q==
X-Received: by 2002:ad4:4191:0:b0:658:3608:28e0 with SMTP id
 e17-20020ad44191000000b00658360828e0mr4134776qvp.1.1695139347380; 
 Tue, 19 Sep 2023 09:02:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t29-20020a0cb39d000000b0063d162a8b8bsm4493058qve.19.2023.09.19.09.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 09:02:27 -0700 (PDT)
Date: Tue, 19 Sep 2023 12:02:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, leobras@redhat.com
Subject: Re: [PATCH 19/52] migration/rdma: Fix qemu_get_cm_event_timeout() to
 always set error
Message-ID: <ZQnGEaio3/BAzDMx@x1n>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-20-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918144206.560120-20-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Sep 18, 2023 at 04:41:33PM +0200, Markus Armbruster wrote:
> qemu_get_cm_event_timeout() neglects to set an error when it fails
> because rdma_get_cm_event() fails.  Harmless, as its caller
> qemu_rdma_connect() substitutes a generic error then.  Fix it anyway.
> 
> qemu_rdma_connect() also sets the generic error when its own call of
> rdma_get_cm_event() fails.  Make the error handling more obvious: set
> a specific error right after rdma_get_cm_event() fails.  Delete the
> generic error.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


