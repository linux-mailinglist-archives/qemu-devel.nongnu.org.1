Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0796880078B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:51:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r90A3-0002zM-3n; Fri, 01 Dec 2023 04:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r909u-0002z3-8U
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:50:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r909s-0007kJ-1t
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701424200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVQ1vfbpJyKVsP0uJBrPdq0w7lPym5vwh/SmSS4AnZg=;
 b=Pjhs0Ya6niH5t+/Y3C/6MaIREQLxowmXx5Ocw/iuKQNQkTLmgsW53lpKMOGLuS5UBYVN/J
 yZi9s65GDymcCBdiRal/OsVJRp/SWGGTzq4jLXVGzetpUdHkQ/eEch4C6aHjOrg7EQLYJl
 WVjlLt3bU2bIzTkSbaDUiDZrDBEE2Ow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-QXvlVHVDNYKtGwP7xCTypA-1; Fri, 01 Dec 2023 04:49:55 -0500
X-MC-Unique: QXvlVHVDNYKtGwP7xCTypA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35FE9101A53B;
 Fri,  1 Dec 2023 09:49:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A12062026D6E;
 Fri,  1 Dec 2023 09:49:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9814C21E6A1F; Fri,  1 Dec 2023 10:49:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  vsementsov@yandex-team.ru,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 jsnow@redhat.com,  crosa@redhat.com,  bleal@redhat.com,
 eblake@redhat.com,  armbru@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  alxndr@bu.edu,  bsd@redhat.com,
 stefanha@redhat.com,  thuth@redhat.com,  darren.kenny@oracle.com,
 Qiuhao.Li@outlook.com,  lvivier@redhat.com
Subject: Re: [PATCH v6 2/4] qmp: add dump machine type compatible properties
References: <20231108153827.39692-1-davydov-max@yandex-team.ru>
 <20231108153827.39692-3-davydov-max@yandex-team.ru>
Date: Fri, 01 Dec 2023 10:49:53 +0100
In-Reply-To: <20231108153827.39692-3-davydov-max@yandex-team.ru> (Maksim
 Davydov's message of "Wed, 8 Nov 2023 18:38:25 +0300")
Message-ID: <87sf4mxnem.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

I apologize for the lateness of my review.

Maksim Davydov <davydov-max@yandex-team.ru> writes:

> To control that creating new machine type doesn't affect the previous
> types (their compat_props) and to check complex compat_props inheritance
> we need qmp command to print machine type compatible properties.
>
> This patch adds the ability to get list of all the compat_props of the
> corresponding supported machines for their comparison via new optional
> argument of "query-machines" command.

Sounds like this is to let developers prevent unwanted change.  Such
testing interfaces need not and should not be stable interfaces.
Thoughts?

> Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/core/machine-qmp-cmds.c  | 23 +++++++++++++++-
>  qapi/machine.json           | 54 +++++++++++++++++++++++++++++++++++--
>  tests/qtest/fuzz/qos_fuzz.c |  2 +-
>  3 files changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 3860a50c3b..a49d0dc362 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -66,7 +66,8 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>      return head;
>  }
>  
> -MachineInfoList *qmp_query_machines(Error **errp)
> +MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
> +                                    Error **errp)
>  {
>      GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
>      MachineInfoList *mach_list = NULL;
> @@ -98,6 +99,26 @@ MachineInfoList *qmp_query_machines(Error **errp)
>              info->default_ram_id = g_strdup(mc->default_ram_id);
>          }
>  
> +        if (compat_props && mc->compat_props) {
> +            int i;
> +            info->compat_props = NULL;
> +            CompatPropertyList **tail = &(info->compat_props);
> +            info->has_compat_props = true;
> +
> +            for (i = 0; i < mc->compat_props->len; i++) {
> +                GlobalProperty *mt_prop = g_ptr_array_index(mc->compat_props,
> +                                                            i);
> +                CompatProperty *prop;
> +
> +                prop = g_malloc0(sizeof(*prop));
> +                prop->driver = g_strdup(mt_prop->driver);
> +                prop->property = g_strdup(mt_prop->property);
> +                prop->value = g_strdup(mt_prop->value);
> +
> +                QAPI_LIST_APPEND(tail, prop);
> +            }
> +        }
> +
>          QAPI_LIST_PREPEND(mach_list, info);
>      }
>  
> diff --git a/qapi/machine.json b/qapi/machine.json
> index b6d634b30d..8ca0c134a2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -135,6 +135,25 @@
>  ##
>  { 'command': 'query-cpus-fast', 'returns': [ 'CpuInfoFast' ] }
>  
> +##
> +# @CompatProperty:
> +#
> +# Machine type compatible property. It's based on GlobalProperty and created
> +# for machine type compat properties (see scripts)

"compatibility property"

Doc comments are user documentation.  Can we describe this without
referencing C data types like GlobalProperty?  I'd start with the
purpose: specify a default value for a certain property of certain kind
of device.

The reference (see scripts) needs to be more precise to be useful.

Limit line length to 70, please.

Two spaces between sentences for consistency, please.

> +#
> +# @driver: name of the driver that has GlobalProperty
> +#
> +# @property: global property name
> +#
> +# @value: global property value

I don't like these descriptions, but let's improve the paragraph above
them first.

> +#
> +# Since: 8.2

Going to be 9.0.  More of the same below.

> +##
> +{ 'struct': 'CompatProperty',
> +  'data': { 'driver': 'str',
> +            'property': 'str',
> +            'value': 'str' } }
> +
>  ##
>  # @MachineInfo:
>  #
> @@ -166,6 +185,9 @@
>  #
>  # @acpi: machine type supports ACPI (since 8.0)
>  #
> +# @compat-props: List of compatible properties that defines machine type

"The machine type's compatibility properties"

Leaves unsaid when the member is present.  Let's worry about that later.

> +#                (since 8.2)
> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'MachineInfo',
> @@ -173,18 +195,46 @@
>              '*is-default': 'bool', 'cpu-max': 'int',
>              'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
>              'deprecated': 'bool', '*default-cpu-type': 'str',
> -            '*default-ram-id': 'str', 'acpi': 'bool' } }
> +            '*default-ram-id': 'str', 'acpi': 'bool', '*compat-props': ['CompatProperty'] } }

Long line, break it before '*compat-props', please.

To mark the interface unstable, do something like

               '*compat-props': { 'type': ['CompatProperty'],
                                  'features': [ 'unstable' ] },

You may want to rename it to x-compat-props, just to make "unstable"
obvious to human users.

>  
>  ##
>  # @query-machines:
>  #
>  # Return a list of supported machines
>  #
> +# @compat-props: if true return will contain information about machine type
> +#                compatible properties (since 8.2)

"compatibility properties"

Suppressing parts of the output makes sense only if it's fairly big.
How much additional compat-props output do you observe?

> +#
>  # Returns: a list of MachineInfo
>  #
>  # Since: 1.2
> +#
> +# Example:
> +#
> +# -> { "execute": "query-machines", "arguments": { "compat-props": true } }
> +# <- { "return": [
> +#          {
> +#              "hotpluggable-cpus": true,
> +#              "name": "pc-q35-6.2",
> +#              "compat-props": [
> +#                  {
> +#                      "driver": "virtio-mem",
> +#                      "property": "unplugged-inaccessible",
> +#                      "value": "off"
> +#                   }
> +#               ],
> +#               "numa-mem-supported": false,
> +#               "default-cpu-type": "qemu64-x86_64-cpu",
> +#               "cpu-max": 288,
> +#               "deprecated": false,
> +#               "default-ram-id": "pc.ram"
> +#           },
> +#           ...
> +#    }
>  ##
> -{ 'command': 'query-machines', 'returns': ['MachineInfo'] }
> +{ 'command': 'query-machines',
> +  'data': { '*compat-props': 'bool' },
> +  'returns': ['MachineInfo'] }
>  
>  ##
>  # @CurrentMachineParams:
> diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
> index e403d373a0..b71e945c5f 100644
> --- a/tests/qtest/fuzz/qos_fuzz.c
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -46,7 +46,7 @@ static void qos_set_machines_devices_available(void)
>      MachineInfoList *mach_info;
>      ObjectTypeInfoList *type_info;
>  
> -    mach_info = qmp_query_machines(&error_abort);
> +    mach_info = qmp_query_machines(false, false, &error_abort);
>      machines_apply_to_node(mach_info);
>      qapi_free_MachineInfoList(mach_info);


