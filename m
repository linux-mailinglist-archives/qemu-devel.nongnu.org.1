Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA17DD86B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:38:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxNF-00032E-L9; Tue, 31 Oct 2023 18:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxxND-000326-JF
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxxNB-0002Y5-Vm
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698791889;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=i5oHUchxHVYA3uTyHZJqeXfvGBrvkVBLPTYfXhXAW9U=;
 b=LiOf8kZUTAHml71u2+UWSEG3Oq2HzcMrIUwLjXJOxkJKEQ+ZwhEvo0WXD21xpOftEspCXp
 fQJ6K5WaF4p1DjdFWUJWChSGJWzRp2ExdD87K4/F7ilyG7dI0o5v9sb9lVCZ7CjLtv2T8l
 4zrrH5tuD/qvs0Y7DlCJum1vckbo5Uo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-zqUPZZhzMEOzRUvX2Fugsw-1; Tue, 31 Oct 2023 18:38:07 -0400
X-MC-Unique: zqUPZZhzMEOzRUvX2Fugsw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so44022345e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698791886; x=1699396686;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i5oHUchxHVYA3uTyHZJqeXfvGBrvkVBLPTYfXhXAW9U=;
 b=AHndMt6tVpwM50FOLr2h1TsfUhdVd1E7bFlg0ZuC2x3Jr0leq6kb0J8hTiWReoZxsS
 hKS8kxgleNOflI5yJxVA6ZebQWurjX642gioGS+39SiOVYwPj89TKBh3cN830kYN/Xp8
 /z0kE7u9u1KHQZspIzK3El0y8XIhaXFUeq9CjFlt/Oy5CrP8AmSivaxrUB5EjIUumTKH
 O91sH3Ae6SPYYL9gk7Tklrzzr4zl0X9Kl+fXSoGG9mbc9amQPC6MZD3OiTLM1KkHVbd6
 4P1FwKRXQqHJnxrgPpBVnVICbORjoRNUm1YKljDL60a6XAr6/h9pviiW8/I68Mr9cZCB
 WbbQ==
X-Gm-Message-State: AOJu0YzoMRW58tPHQMN8/jQhE/mpQWiWC8oXBsi3ALIq8+WNXJEmiH1+
 kvX4d+TIedh+HP6RF5JN37JzUamPUMwHs6/JjVe9sZcTiBDflBseaUoWm0tYM5L4YqCTAwH30zO
 4aGkZ6BksCcVvd/Y=
X-Received: by 2002:a05:600c:3d8c:b0:406:5308:cfeb with SMTP id
 bi12-20020a05600c3d8c00b004065308cfebmr11394490wmb.11.1698791886206; 
 Tue, 31 Oct 2023 15:38:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnRkU7NpQ+XOMzPIm4jy/cjv+1Hd3sCR5sARCHLXBJHA5x5RedDWyvXLUsi99qYb9KQXhhjA==
X-Received: by 2002:a05:600c:3d8c:b0:406:5308:cfeb with SMTP id
 bi12-20020a05600c3d8c00b004065308cfebmr11394474wmb.11.1698791885846; 
 Tue, 31 Oct 2023 15:38:05 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 dl19-20020a05600c669300b004080f0376a0sm2822149wmb.42.2023.10.31.15.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 15:38:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>,  "open list:All patches CC here"
 <qemu-devel@nongnu.org>,  Prerna Saxena <prerna.saxena@nutanix.com>,
 dgilbert@redhat.com,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 Berrange <berrange@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Manish Mishra
 <manish.mishra@nutanix.com>,  Aravind Retnakaran
 <aravind.retnakaran@nutanix.com>,  Peter Xu <peterx@redhat.com>,  Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v15 13/14] migration: Implement MigrateChannelList to
 hmp migration flow.
In-Reply-To: <896322bb-93c6-0eef-c87e-fcdd90c38f51@nutanix.com> (Het Gala's
 message of "Wed, 1 Nov 2023 00:39:21 +0530")
References: <20231023182053.8711-1-farosas@suse.de>
 <20231023182053.8711-14-farosas@suse.de>
 <87msvy4rjg.fsf@secure.mitica>
 <d746e4d6-1572-2360-3780-7be4ae63ac29@nutanix.com>
 <CAGiv1-VF9mCq7B-6RCHPONT43Zd8YTH87xJXFbdf5GLcY_dbcQ@mail.gmail.com>
 <896322bb-93c6-0eef-c87e-fcdd90c38f51@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 23:38:04 +0100
Message-ID: <87a5ry4dv7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Het Gala <het.gala@nutanix.com> wrote:
> On 01/11/23 12:25 am, Juan Quintela wrote:
>> I intrehated al parches until this forma next pull.
> I should just add the last 2 patches as individual ones, is that what
> you mean ?

Take a look at:

https://gitlab.com/juan.quintela/qemu/-/commits/migration-next

This is my next PULL request on top of the one already on the list.

https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg10281.html

I just did that O:-)

Later, Juan.

>> On Tue, Oct 31, 2023, 19:51 Het Gala <het.gala@nutanix.com> wrote:
>>
>>
>>     On 31/10/23 11:12 pm, Juan Quintela wrote:
>>     > Fabiano Rosas <farosas@suse.de> wrote:
>>     >> From: Het Gala <het.gala@nutanix.com>
>>     >>
>>     >> Integrate MigrateChannelList with all transport backends
>>     >> (socket, exec and rdma) for both src and dest migration
>>     >> endpoints for hmp migration.
>>     >>
>>     >> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>     >> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>     >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>     >
>>
>>     > Later, Juan.
>>     Regards,
>>     Het Gala
>>
> Regards,
> Het Gala


