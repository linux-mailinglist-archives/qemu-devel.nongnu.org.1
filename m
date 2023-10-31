Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F37DD82D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:21:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxx5q-00052t-Ff; Tue, 31 Oct 2023 18:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxx5m-00052W-Cv
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxx5k-00081t-Ps
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698790805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wgj4hY+XcWc47BXU0XZDqWWA5lbQyYl/lQt4+ozizik=;
 b=Pnk9yO2KogIj1ksMnuz/yuCOA0ZQkUbeAePvObJh8vARl8yaIMlSje0O9CNmrgA0Nv0/8e
 dvhadwcJWm42vWLXqJ2lR7C4xSak2iQWIuumXCFFcbkWgn/6Jmi0kAIK6Lz+7qpAo2VXMd
 8AvG2Dlp8mix3THRzSnFz66JZdT1jBU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-ZCn2YCGONE-_zvrXrcqV8w-1; Tue, 31 Oct 2023 18:19:59 -0400
X-MC-Unique: ZCn2YCGONE-_zvrXrcqV8w-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77a02ceef95so100015085a.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698790799; x=1699395599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wgj4hY+XcWc47BXU0XZDqWWA5lbQyYl/lQt4+ozizik=;
 b=m3S+ND8EoM919s2sIh0ujGBcSXIQ95q4dL6lzkwun/FmIVaWDnEVqIUYqK48xe7Z0M
 QOuTT0OHQX7nC9QlynMvlp59ybhWVHCpfFb0mmpThyopU5iNGIxx542HxIizgi2+94ve
 35Aqe/9m8FpMPYJbo5hwvCuhTW7zw235Z/O8yraB7kGg6mOkFb9Qh12ywsN5yTzLUesy
 jVSN1Rgrnk6hSSym69SVd+XC3IvUMo0R4gncidiYWhe8HyBoMhVGdfmgUUDzX/4Dz1wS
 oxhGD6RI3xb/DNHand2TOuT2V+FMracz1IsxxPYJdKHNtsarhfWrSd54ThgJDp69lOZX
 RqBQ==
X-Gm-Message-State: AOJu0YzFmn1TJaCI0JBL+j9YB9PO579x/9F7Jq30X1Tn8vRd93ctaW59
 2y1AG1k4pfh8tFolFCc/Zl2q9jMNb4nId59o56I4yk4Q42EZDdaWKsL5pZsUCTb9B8i6bVywElO
 r1cfVZjugCjJRnAQ=
X-Received: by 2002:a05:620a:4552:b0:770:f2bb:37c3 with SMTP id
 u18-20020a05620a455200b00770f2bb37c3mr17991176qkp.6.1698790798871; 
 Tue, 31 Oct 2023 15:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa0LVtMrWPcUCxl5KFY6KxGofrmDrnTtLGPt9+8bXNIDofWLLOQWBDtPlzpOW6c9TAwOU0Wg==
X-Received: by 2002:a05:620a:4552:b0:770:f2bb:37c3 with SMTP id
 u18-20020a05620a455200b00770f2bb37c3mr17991162qkp.6.1698790798609; 
 Tue, 31 Oct 2023 15:19:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 os24-20020a05620a811800b007759a81d88esm875321qkn.50.2023.10.31.15.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 15:19:58 -0700 (PDT)
Date: Tue, 31 Oct 2023 18:19:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v4 3/5] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
Message-ID: <ZUF9jKZObY01WMS/@x1n>
References: <20231017202633.296756-1-peterx@redhat.com>
 <20231017202633.296756-4-peterx@redhat.com>
 <87o7gecuzl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7gecuzl.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 31, 2023 at 07:01:02PM -0300, Fabiano Rosas wrote:
> This patch breaks the windows build. We need this:

Oops..

I hope this can still catch Juan's next pull, or I'll squash the fix if to
repost.

Thanks,

-- 
Peter Xu


