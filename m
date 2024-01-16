Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC082E9C3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:04:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPdU5-0006Q3-PI; Tue, 16 Jan 2024 02:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPdU3-0006JN-49
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:03:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPdU1-00081q-Oe
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705388616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/VlbXunGsQKnNEEJB7kNgi88H1/nhiKiVtDqnC2DgU=;
 b=dE8grhI2QKiOJMyBeM4DM/7lM5L0Ewm/J9Wk0mu0aYQRj2BC+vs0qsBcERZRt4S7vj7zcI
 o8AyQNGTHoT3dzRqWX06sNhdpNj986JokbPVC4zW93DIPo92BcGhOhGhcSf/hdl/xRBtAJ
 ypSWp2dQ6IhJJxunNaik1tIwg4k2UeM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-O9VeM9EjPNqnsRIfC97B-w-1; Tue, 16 Jan 2024 02:03:34 -0500
X-MC-Unique: O9VeM9EjPNqnsRIfC97B-w-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5ca4e0122f6so193894a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 23:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705388614; x=1705993414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/VlbXunGsQKnNEEJB7kNgi88H1/nhiKiVtDqnC2DgU=;
 b=SjOh5lIKNILc4Zv45M4BNzePy16OoulfFxc8dDbK26ZpAGGR9dEaUAgr6bqTQcszQu
 Ihj/oRBuBxX1VMrvuHgcXLl8lu0Z2Ni29pLSZLWgY90nJNnIxGc16bXG9w1xF+FsdE0T
 SOd9lgcjPhfYUBjyhwBy6HX+ih5NdH29tKN3YQj/y67ylBwwFnkbfBOoz6WoGcFDgynf
 amSiOT6o/f7shJn+bEXcM2s76nq91S80zH9E0mFRGySP6F+SpKlFk0f0+5i9vrEh5OCf
 0YXkKsT7QPFNZc22kEfKeTgN80FqoOdUZREDrim5kOhso1UN1My720//SGLDtX6sAZV6
 SSLA==
X-Gm-Message-State: AOJu0YxMM3Fgajn+9txokYArqjzB04pnZaTHxyfuwKozgZEjQfMnNW/0
 2+wjIHWVBHELXJ7F6T54Kt7DfAJaPe9hyjNNGiOiLht6LMUYX1nRk1qARfAPUrr6MxV/jg+H5UG
 UrsuMG18Q2QLESxPP15XDeT8=
X-Received: by 2002:a17:902:a711:b0:1d3:cf95:fd4b with SMTP id
 w17-20020a170902a71100b001d3cf95fd4bmr13237045plq.6.1705388613811; 
 Mon, 15 Jan 2024 23:03:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5PkJPn+Z4fvy4xRTrkEXcYEEqsq9bGVlvoOn5QMGtzPugoow/HWIh6InxrAQWkm6GqE2VrA==
X-Received: by 2002:a17:902:a711:b0:1d3:cf95:fd4b with SMTP id
 w17-20020a170902a71100b001d3cf95fd4bmr13237028plq.6.1705388613462; 
 Mon, 15 Jan 2024 23:03:33 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ki3-20020a170903068300b001d5ed020153sm284324plb.224.2024.01.15.23.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 23:03:33 -0800 (PST)
Date: Tue, 16 Jan 2024 15:03:25 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 16/30] multifd: Rename MultiFDSendParams::data to
 compress_data
Message-ID: <ZaYqPdKFlK3_uusa@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127202612.23012-17-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 27, 2023 at 05:25:58PM -0300, Fabiano Rosas wrote:
> Use a more specific name for the compression data so we can use the
> generic for the multifd core code.

You also modified the recv side.  Touch up the subject would be nice to say
both.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>


-- 
Peter Xu


