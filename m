Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 494E17A63ED
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaFQ-0008Lr-P8; Tue, 19 Sep 2023 08:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qiaFM-0008LX-S6
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qiaFL-0005mw-BX
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695128069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAHJCWjTFPNsc90pYztbLiErgb7IGGHoHzTCi0Vn/WQ=;
 b=IqG6XQBLaIw08ro3qD/d5+kkQ6IjiVtNsEfheLF/i69JymCjfdluh6Hvt8wSFsFmHGp7c2
 c5Z5eFmkDOwWOijb94DPg0iUhIiCzHms1/OqFkTu57vt4H3X04MaFeN0EyU8RghjjIAy73
 FzeddCcR8n4th+cHrIvJ051CwBc1QYI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Bl-__hbSMlC8kwrghkIg_A-1; Tue, 19 Sep 2023 08:54:28 -0400
X-MC-Unique: Bl-__hbSMlC8kwrghkIg_A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32006e08483so1821881f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 05:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695128067; x=1695732867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aAHJCWjTFPNsc90pYztbLiErgb7IGGHoHzTCi0Vn/WQ=;
 b=NJGNNWoVT6zZNajJHf0NpUkuneo3vY7qZmVY70eKJlC+vHz36aiX2fHM/jm+d9f4bV
 Xw/iA2jb+42b9PeM8/5aDtT5cH/3/3F82BZ/35aBlzhQDhx53dsrjAeB2NlP5oGTqqaf
 JOjU2N0rLLwwtdStbb9EbP0dPI8YGt2GcY7zolCFjGoLEZLCgTlk5ZVLbzX3No646AJb
 KVc8qrs7von/E6s5fxS7JR2iY4kozlC+DQ0A8QCTEm74eG5y3ibqkDs7+gYUFDTLdbP4
 hOikmq+wGxiyeyTNNRo3e45EVyipKU4O3mox3wkJ0b032MrOEvcnO/qSLgRGM2wVPHko
 yiUA==
X-Gm-Message-State: AOJu0YzegrTkTrgAZmk9maZDLbXkn9dAK5zjARrHadLSzUtm67LF285N
 m4xoE620dvXi/d6RiAk20BlrFo/exJJQ9W8n+wPvAWvhT/Gx0HLCyfIu3XJu2ZszNWVVkUjWAXO
 0mczasbxaYfHDQgc=
X-Received: by 2002:adf:b60b:0:b0:321:61c1:7879 with SMTP id
 f11-20020adfb60b000000b0032161c17879mr3473937wre.30.1695128067443; 
 Tue, 19 Sep 2023 05:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlBI6RhapD4Bf34CdkCt975lNwBH1JzWEUylwsKYHNpd/nvieCfiKQRB8XwSvh58TTnS/wvw==
X-Received: by 2002:adf:b60b:0:b0:321:61c1:7879 with SMTP id
 f11-20020adfb60b000000b0032161c17879mr3473922wre.30.1695128067060; 
 Tue, 19 Sep 2023 05:54:27 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.googlemail.com with ESMTPSA id
 l16-20020adffe90000000b0031aef72a021sm984557wrr.86.2023.09.19.05.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Sep 2023 05:54:26 -0700 (PDT)
Message-ID: <4b890258-3426-0e0f-dd65-6114b9bee5e3@redhat.com>
Date: Tue, 19 Sep 2023 14:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 05/18] ui/vc: console-vc requires PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
 <20230918135206.2739222-6-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230918135206.2739222-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/18/23 15:51, marcandre.lureau@redhat.com wrote:
>           return "vc:80Cx24C";
> +#else
> +        return "null";

Maybe return NULL and then add some heuristics in vl.c:

      const char *vc = qemu_display_get_vc(&dpy);
      if (nographic ||
          (!vc && !is_daemonized() && isatty(STDOUT_FILENO)) {
          ...
      } else {
         if (default_serial)
             add_device_config(DEV_SERIAL, vc ? vc : "null");
         if (default_parallel)
             add_device_config(DEV_PARALLEL, vc ? vc : "null");
         if (default_monitor && vc)
             monitor_parse(vc, "readline", false);
      }

This would use a muxed console on stdio if pixman is disabled.

Paolo


