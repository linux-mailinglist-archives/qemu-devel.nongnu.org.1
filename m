Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313C77FA351
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:44:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7cqR-0002GG-7V; Mon, 27 Nov 2023 09:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7cqP-0002Eb-IB
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r7cqO-0002Z8-7Z
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701096254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=00w9x3kmMAQlXB12F/1YU9KqqsmeJKzlWwxHtry6XdU=;
 b=FfdSxE9XdeRBug25buNBXiHGzA+V0hWo5IzRj39i8/TCJUQsSw8Mb8vUpe94EVeE91qIqn
 BP2440wfhFUejEPSzYcwbIIVoGzdSmcGYhkqfiCugJeNmLY28LVUcaNh3U3zmx+JCvDsvF
 WPNaz9vQicOh0oFwFNW4fPaRwEMyYwE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-bIjemr8HOTeZm8SDLKr4Cw-1; Mon, 27 Nov 2023 09:44:13 -0500
X-MC-Unique: bIjemr8HOTeZm8SDLKr4Cw-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-6d815fa3b84so575089a34.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 06:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701096252; x=1701701052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00w9x3kmMAQlXB12F/1YU9KqqsmeJKzlWwxHtry6XdU=;
 b=ImWbKVxPX/hd2XhT3Idih5cFK8E9nRwEFA+rKzd9dCY3c1MuVw322gvqzJzxse2Wbj
 HFkcw6IorNl+pB5UxJUpiUSWnrTEmKV+uutEQ9OLIS0GkYml1ODshvPakvgxO/Cd9h2m
 uvcuLbi89sOz2adn+VzWf7plUpWiloRMIvPWtR71LmE5ET2KaZwzfcngXpSLYjIFuhFc
 arhm8GuwSJRUxUy17FgsUUZJP3pmcK0SlRjcpuPK2lW/4L/8mTSfXtZgIKNUX+MjN6Fs
 trzRvLI4GbsMHC9GSEYLwHuUmQczjihEXO9h/CfM2abfpam2hFw3X5QkTtm31AQlAirW
 Bz1w==
X-Gm-Message-State: AOJu0YzEBpWb/jlCTKxdf9oWM1Qn5iLOJLN+9+xxnvuQMT6G0yIphVke
 Ja3PT+rtngYZYCplylKfGsSwCMQwSzD02/CqZpJpqmScoIwQfL4rwiEge2KcTcF2jsDlUxAxKIP
 78E5aosnR93KPFvo=
X-Received: by 2002:a05:6830:1c9:b0:6d3:3332:fbfb with SMTP id
 r9-20020a05683001c900b006d33332fbfbmr12038536ota.0.1701096252619; 
 Mon, 27 Nov 2023 06:44:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElfCizt31PSPnbIBb5nd/n4dsG92BSMt8lrJqODf2nG8lg43Dr0cd7zzPvEuIjQaiF1cKQig==
X-Received: by 2002:a05:6830:1c9:b0:6d3:3332:fbfb with SMTP id
 r9-20020a05683001c900b006d33332fbfbmr12038520ota.0.1701096252399; 
 Mon, 27 Nov 2023 06:44:12 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 j6-20020a0ceb06000000b0067a4beedd77sm540089qvp.29.2023.11.27.06.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 06:44:12 -0800 (PST)
Date: Mon, 27 Nov 2023 09:44:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v1 2/7] migration/multifd: Remove QEMUFile from where it
 is not needed
Message-ID: <ZWSrO74_ugzORc2o@x1n>
References: <20231124161432.3515-1-farosas@suse.de>
 <20231124161432.3515-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231124161432.3515-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Nov 24, 2023 at 01:14:27PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


